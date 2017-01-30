#!/bin/bash

set -e  # exit on error

echo "*** ONOS build script"

echo "*** Fetching ONOS source code"
builddir=onos-`date +%y%m%d-%H%M%S`
mkdir $builddir
git clone https://gerrit.onosproject.org/onos $builddir

pushd $builddir

echo "*** Running ONOS unit tests (ignoring failures)"
tools/build/onos-buck test 1>/dev/null || true

echo "*** Building onos.tar.gz package"
export ONOS_ROOT=  # in case it's set to point elsewhere
echo "onos_root is $ONOS_ROOT"
env | grep -i onos
tools/build/onos-buck build onos 1>/dev/null

popd

echo "*** Copying onos.tar.gz to onos-$tag.tar.gz"
cp $builddir/buck-out/gen/tools/package/onos-package/onos.tar.gz onos-$tag.tar.gz

echo "*** ONOS build complete"
exit 0
