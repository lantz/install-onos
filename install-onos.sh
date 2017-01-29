#!/bin/bash

set -e  # exit on error

echo "*** ONOS Installation Script"

echo "*** Installing Oracle Java 8"
apt-get -qq install software-properties-common
add-apt-repository ppa:webupd8team/java
apt-get -qq update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
apt-get -qq install oracle-java8-installer oracle-java8-set-default

echo "*** Checking for ONOS archive in this directory"
ONOS_TAR=($(echo onos*.tar.gz))
if [ ! -r $ONOS_TAR ]; then
    ONOS_TAR=onos-1.8.0.tar.gz
    echo "*** Fetching $ONOS_TAR"
    wget -c http://downloads.onosproject.org/nightly/$ONOS_TAR
fi

echo "*** Unpacking $ONOS_RELEASE.tar.gz into /opt/onos and creating symlinks"
mkdir -p /opt
rm -rf /opt/onos*
tar xzf $ONOS_TAR -C /opt
ln -s /opt/onos-* /opt/onos
ln -s /opt/onos/*karaf-* /opt/onos/karaf

echo "*** Configuring ONOS user and group, and default apps"
adduser onos --system --group < /dev/null
tee /opt/onos/options <<EOF
export ONOS_USER=onos
export ONOS_APPS=drivers,openflow,proxyarp,mobility,fwd
EOF

echo "*** Copying init files"
cp /opt/onos/init/onos.initd /etc/init.d/onos  # base / system V, e.g. Ubuntu 12.04; also called by systemd script
[ -d /etc/init/ ] && cp /opt/onos/init/onos.conf /etc/init/onos.conf  # upstart, e.g. Ubuntu 14.04
[ -d /etc/systemd/system/ ] && cp /opt/onos/init/onos.service /etc/systemd/system/  # systemd, e.g. Ubuntu 16.04
which systemctl > /dev/null && ( systemctl daemon-reload; systemctl enable onos )   # systemd

echo "*** Starting ONOS"
service onos start

echo "*** Checking ONOS status"
service onos status
