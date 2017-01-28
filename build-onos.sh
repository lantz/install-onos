#!/bin/bash

set -e  # exit on error

echo "*** ONOS build script"

echo "*** Fetching ONOS source code"
builddir=onos-`date +%y%m%d-%H%M%S`
mkdir $builddir
cd $builddir
git clone https://gerrit.onosproject.org/onos

echo "*** Building ONOS"
pushd onos
export ONOS_ROOT=  # in case it's set to point elsewhere
echo "onos_root is $ONOS_ROOT"
env | grep -i onos
tools/build/onos-buck build onos
popd

echo "*** Copying onos.tar.gz to" `pwd`
cp onos/buck-out/gen/tools/package/onos-package/onos.tar.gz .

echo "*** ONOS build complete"
exit 0
