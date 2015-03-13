easy-build
==========

[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/gmacario/easy-build?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![PullReview stats](https://www.pullreview.com/github/gmacario/easy-build/badges/master.svg?)](https://www.pullreview.com/github/gmacario/easy-build/reviews/master)
[![Stories in Ready](https://badge.waffle.io/gmacario/easy-build.png?label=ready&title=Ready)](https://waffle.io/gmacario/easy-build)

This repository contains a collection of [Docker](http://www.docker.com/)
files that help rebuilding a few embedded software distributions.

| Subproject               | Description                             |
| ------------------------ | --------------------------------------- |
| [build-aosp][1]          | Android Open Source Project             |
| [build-openwrt][2]       | OpenWrt                                 |
| [build-yocto][3]         | Yocto Project                           |
| [build-yocto-fsl-arm][4] | Yocto Project for Freescale/ARM targets |
| [build-yocto-genivi][5]  | Yocto GENIVI Baseline                   |

Please refer to the `README.md` file available under each subdirectory for details.

[1]: build-aosp
[2]: build-openwrt
[3]: build-yocto
[4]: build-yocto-fsl-arm
[5]: build-yocto-genivi

System Requirements
-------------------

* Docker 0.9.1 or later (tested with [Ubuntu](http://www.ubuntu.com/)
and [CoreOS](https://coreos.com/))
* A fast Internet connection

Usage Examples
--------------

### Running a pre-built image available at the Docker Hub

Most of the _build-subproject_ have a corresponding Docker image
`gmacario/<build-subproject>` automatically built and kept updated
on [Docker Hub](https://hub.docker.com/).

The easiest way for using them is by using the `./run.sh` script which
is present inside each _build-subproject_ subdirectory:

    $ cd <build-subproject>
    $ ./run.sh

For details about how to do after please refer to the `README.md` file
in each _build-subproject_ subdirectory.

### Locally building a Docker image for one easy-build subproject

If you are not satisfied or do not trust the Docker images available
on [Docker Hub](https://hub.docker.com/), you may create your own ones
by executing the following commands:

    $ cd <build-subproject>
    $ ./build.sh

If the `build.sh` command is successful, you will eventually get
a `gmacario/<build_subproject>` image inside your local Docker installation.

Please read the `build.sh` script and the corresponding `Dockerfile` for details.

------------------------
Copyright 2014-2015, [Gianpaolo Macario](http://gmacario.github.io/)

<!-- EOF -->
