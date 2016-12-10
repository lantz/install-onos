#!/bin/bash

set -e  # exit on error

echo "*** ONOS Install script"

echo "*** Installing ONOS dependencies"
apt-get install software-properties-common -y
add-apt-repository ppa:webupd8team/java -y
apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
apt-get install oracle-java8-installer oracle-java8-set-default -y

echo "*** Fetching ONOS"
wget -c http://downloads.onosproject.org/nightly/onos-1.8.0-rc4.tar.gz

echo "*** Unpacking ONOS archive and creating symlinks"
mkdir -p /opt
rm -rf /opt/onos*
tar  xzf onos*.tar.gz -C /opt
ln -s /opt/onos-* /opt/onos
ln -s /opt/onos/*karaf-* /opt/onos/karaf

echo "*** Configuring ONOS user and group, and default apps"
adduser onos --system --group < /dev/null
tee /opt/onos/options <<EOF
export ONOS_USER=onos
export ONOS_APPS=drivers,openflow,proxyarp,mobility,fwd
EOF

# echo "*** Fixing permissions - do we need to do this?"
# chown -R onos /opt/onos/

echo "*** Copying init files"
cp /opt/onos/init/onos.initd /etc/init.d/onos
cp /opt/onos/init/onos.conf /etc/init/onos.conf
which systemctl > /dev/null && ( systemctl daemon-reload; systemctl enable onos )

echo "*** Starting ONOS"
service onos start

echo "*** Checking ONOS status"
if which systemctl > /dev/null; then
   systemctl status onos -l --no-pager
else
   service onos status
fi

echo "*** Checkint whether java is running"
pgrep java
