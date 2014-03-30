easy-build
==========

This repository contains a collection of Docker files that help rebuilding embedded software distributions.

Please refer to the README.md files under each subdirectory for details:

* build-yocto-genivi: [Yocto GENIVI Baseline][http://projects.genivi.org/GENIVI_Baselines/meta-ivi/home]
* build-aosp: [Android Open Source Project][http://source.android.com/source/index.html]

System Requirements
-------------------

* Docker 0.9.1 or later (tested on Ubuntu and CoreOS)
* A fast Internet connection

Locally building an image from Dockerfile
-----------------------------------------

```
cd <build-something>
docker build -t mybuild .
```

Running locally built image
---------------------------

```
docker run -i -t mybuild
su - build
# TODO
```

Running pre-built image available at the public Docker index
------------------------------------------------------------

```
docker run -i -t gmacario/<build-something>
su - build
# TODO
```
