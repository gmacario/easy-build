easy-build
==========

[![](https://images.microbadger.com/badges/image/gmacario/easy-build.svg)](https://microbadger.com/images/gmacario/easy-build "Get your own image badge on microbadger.com")
[![Gitter](https://badges.gitter.im/JoinChat.svg)](https://gitter.im/gmacario/easy-build?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Stories in Ready](https://badge.waffle.io/gmacario/easy-build.png?label=ready&title=Ready)](https://waffle.io/gmacario/easy-build)
[![Code Triagers Badge](https://www.codetriage.com/gmacario/easy-build/badges/users.svg)](https://www.codetriage.com/gmacario/easy-build)

This repository contains a collection of [Docker](http://www.docker.com/)files that help rebuilding a few embedded software distributions.

| Subproject               | Description                                 |
| ------------------------ | ------------------------------------------- |
| [build-aosp][1]          | Android Open Source Project                 |
| [build-openwrt][2]       | OpenWrt                                     |
| [build-yocto][3]         | Yocto Project                               |
| [build-yocto-genivi][5]  | Yocto GENIVI Baseline, GENIVI Demo Platform |

Please refer to the `README.md` file available under each subdirectory for details and usage examples.

[1]: build-aosp
[2]: build-openwrt
[3]: build-yocto
[5]: build-yocto-genivi

System Requirements
-------------------

* Docker 1.9 or later (tested with [Ubuntu](http://www.ubuntu.com/) and [CoreOS](https://coreos.com/))
* A fast Internet connection

License and Copyright
---------------------

License: [MPL-2.0](LICENSE)

Copyright 2014-2018, [Gianpaolo Macario](http://gmacario.github.io/)

<!-- EOF -->
