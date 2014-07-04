easy-build
==========

This repository contains a collection of [Docker](http://www.docker.com/) files that help rebuilding embedded software distributions.

Please refer to the `README.md` file available under each subdirectory for details:

* build-aosp: [Android Open Source Project](http://source.android.com/source/index.html)
* build-yocto-fsl-arm: [Yocto project](http://www.yoctoproject.arm) for Freescale/ARM targets
* build-yocto-genivi: [Yocto GENIVI Baseline](http://projects.genivi.org/GENIVI_Baselines/meta-ivi/home)

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
