#!/bin/bash

set -e

echo "*** Installing mininet"
apt-get -y install mininet

echo "*** Running netstat"
netstat -atp | egrep ':6653|:6633'

echo "*** Testing ONOS"
mn --controller remote --test pingall
