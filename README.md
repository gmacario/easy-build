easy-build
==========

[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/gmacario/easy-build?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![PullReview stats](https://www.pullreview.com/github/gmacario/easy-build/badges/master.svg?)](https://www.pullreview.com/github/gmacario/easy-build/reviews/master)

This repository contains a collection of [Docker](http://www.docker.com/) files that help rebuilding embedded software distributions.

Please refer to the `README.md` file available under each subdirectory for details:

| Subproject               | Description                             |
| ------------------------ | --------------------------------------- |
| [build-aosp][1]          | Android Open Source Project             |
| [build-openwrt][2]       | OpenWrt                                 |
| [build-yocto][3]         | Yocto Project                           |
| [build-yocto-fsl-arm][4] | Yocto Project for Freescale/ARM targets |
| [build-yocto-genivi][5]  | Yocto GENIVI Baseline                   |

[1]: build-aosp
[2]: build-openwrt
[3]: build-yocto
[4]: build-yocto-fsl-arm
[5]: build-yocto-genivi

System Requirements
-------------------

* Docker 0.9.1 or later (tested on Ubuntu and CoreOS)
* A fast Internet connection

Locally building an image from Dockerfile
-----------------------------------------

Execute the following commands:

    cd <build-something>
    docker build -t mybuild .


Running locally built image
---------------------------

Execute the following commands:

    docker run -i -t mybuild
    su - build
    # (depends on the specialized image being run)


Running pre-built image available at the public Docker index
------------------------------------------------------------

Execute the following commands:

    docker run -i -t gmacario/<build-something>
    su - build
    # (depends on the specialized image being run)
