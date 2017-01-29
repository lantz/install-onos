#!/bin/bash

set -e  # Exit on any error

echo "*** Installing mininet"
apt-get -q -y install mininet

echo "*** Checking ONOS status"
service onos status

echo "*** Waiting for ONOS openflow app startup"
for i in `seq 1 30`; do
  if netstat -atp | egrep ':6653'; then
    break
  fi
  echo -n .
  sleep 1
done

echo "*** Testing ONOS"
mn --controller remote,port=6653 --test pingall
