This set of scripts tests the procedure to install ONOS from the
onos*.tar.gz archive.

It does so by building ONOS master, installing from the .tar.gz,
and performing a simple end-to-end system test using [Mininet][2].

[![Build Status][1]](https://travis-ci.org/lantz/install-onos)

- [build-onos.sh](build-onos.sh):     check out ONOS master, build, and run unit tests
- [install-onos.sh](install-onos.sh): install `onos*.tar.gz` archive on local system
- [test-onos.sh](test-onos.sh):       sanity test for local ONOS installation using Mininet
- [.travis.yml](.travis.yml):         travis CI script for testing against Ubuntu 16.04

[1]: https://travis-ci.org/lantz/install-onos.svg?branch=master
[2]: http://mininet.org
