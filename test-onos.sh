#!/bin/bash

set -e  # Exit on any error

echo "*** Installing mininet"
apt-get -qq install mininet

echo "*** Checking ONOS status"
service onos status

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
netstat -atp | egrep ':6653'

echo "*** Testing ONOS"
mn --controller remote,port=6653 --test pingall
