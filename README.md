easy-build
==========

[![](https://badge.imagelayers.io/gmacario/easy-build:latest.svg)](https://imagelayers.io/?images=gmacario/easy-build:latest 'Get your own badge on imagelayers.io')
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/gmacario/easy-build?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![PullReview stats](https://www.pullreview.com/github/gmacario/easy-build/badges/master.svg?)](https://www.pullreview.com/github/gmacario/easy-build/reviews/master)
[![Stories in Ready](https://badge.waffle.io/gmacario/easy-build.png?label=ready&title=Ready)](https://waffle.io/gmacario/easy-build)

This repository contains a collection of [Docker](http://www.docker.com/)files that help rebuilding a few embedded software distributions.

| Subproject               | Description                             |
| ------------------------ | --------------------------------------- |
| [build-aosp][1]          | Android Open Source Project             |
| [build-openwrt][2]       | OpenWrt                                 |
| [build-yocto][3]         | Yocto Project                           |
| [build-yocto-fsl-arm][4] | Yocto Project for Freescale/ARM targets |
| [build-yocto-genivi][5]  | Yocto GENIVI Baseline                   |

Please refer to the `README.md` file available under each subdirectory for details and usage examples.

[1]: build-aosp
[2]: build-openwrt
[3]: build-yocto
[4]: build-yocto-fsl-arm
[5]: build-yocto-genivi

System Requirements
-------------------

* Docker 1.9 or later (tested with [Ubuntu](http://www.ubuntu.com/) and [CoreOS](https://coreos.com/))
* A fast Internet connection

License and Copyright
---------------------

License: [MPL-2.0](LICENSE)

Copyright 2014-2016, [Gianpaolo Macario](http://gmacario.github.io/)

<!-- EOF -->
