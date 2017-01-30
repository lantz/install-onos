This set of scripts [tests the procedure to install ONOS][4] from the
`onos*.tar.gz` archive.

It does so by [building][1] ONOS master, [installing from the `.tar.gz`][2],
and [performing a simple end-to-end system test][3] using [Mininet][5].

[![Build Status][1]](https://travis-ci.org/lantz/install-onos)

- [`build-onos.sh`][1]:   check out ONOS master, build, and run unit tests
- [`install-onos.sh`][2]: install `onos*.tar.gz` archive on local system
- [`test-onos.sh`][3]:    sanity/ping test for local ONOS installation using Mininet
- [`.travis.yml`][4]:     travis CI script for testing against Ubuntu 16.04


[1]: build-onos.sh
[2]: install-onos.sh
[3]: test-onos.sh
[4]: https://travis-ci.org/lantz/install-onos.svg?branch=master
[5]: http://mininet.org
