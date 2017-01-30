# `install-onos`: ONOS Installation Test Scripts
[![Build Status][6]][5]

This set of scripts [tests][5] the [procedure to install ONOS][2] from an
`onos*.tar.gz` archive. This should mostly match the [documentation][8].

- [`build-onos.sh`][1]:   check out ONOS master, build, and run unit tests
- [`install-onos.sh`][2]: install `onos*.tar.gz` archive on local system
- [`test-onos.sh`][3]:    sanity/ping test for local ONOS installation using [Mininet][7]
- [`.travis.yml`][4]:     travis CI script for testing against Ubuntu 16.04

[1]: build-onos.sh
[2]: install-onos.sh
[3]: test-onos.sh
[4]: .travis.yml
[5]: https://travis-ci.org/lantz/install-onos
[6]: https://travis-ci.org/lantz/install-onos.svg?branch=master
[7]: http://mininet.org
[8]: https://wiki.onosproject.org/x/jQAQ
