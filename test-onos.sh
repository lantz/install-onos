#!/bin/bash

set -e  # Exit on any error

echo "*** Installing mininet"
git clone git://github.com/mininet/mininet
mininet/util/install.sh -nv > /dev/null

echo "*** Checking OVS status"
service openvswitch-switch status

echo "*** Checking ONOS status"
service onos status < /dev/null
ps ax | grep java

echo "*** Dumping ONOS options"
cat /opt/onos/options

echo "*** Waiting for ONOS openflow app startup"
for i in `seq 1 90`; do
  if netstat -atp | egrep ':6653'; then
    break
  fi
  echo -n .
  sleep 1
done

echo "*** Confirming that ONOS is listening on port 6653"
netstat -atp
netstat -atp | egrep ':6653'

echo "*** Testing ONOS"
mn -v debug --controller remote,port=6653 --test pingall
