# build-yocto-genivi

[![](https://badge.imagelayers.io/gmacario/build-yocto-genivi:latest.svg)](https://imagelayers.io/?images=gmacario/build-yocto-genivi:latest 'Get your own badge on imagelayers.io')

**build-yocto-genivi** is a subproject of [easy-build](https://github.com/gmacario/easy-build)
and has the objective of providing a simplified environment where to rebuild from sources

* The [Yocto GENIVI Baseline](http://projects.genivi.org/GENIVI_Baselines/meta-ivi/home)
* The [GENIVI Demo Platform](http://wiki.projects.genivi.org/index.php/GENIVI_Demo_Platform)

in order to run them on virtual targets such as QEMU, VirtualBox or VMware.

**build-yocto-genivi** relies on [Docker](http://www.docker.com/) to provide a clean,
stand-alone development environment complete with all the tools needed to perform
a full build of the target image.

## Getting the Docker image locally

Several options are possible here.

### Pulling image from Docker Hub

The most recent builds of the **build-yocto-genivi** Docker images are published
on [Docker Hub](https://hub.docker.com/) and can be pulled into your Docker machine with the following command:

    $ docker pull gmacario/build-yocto-genivi

### Creating the image from the Dockerfile

You can build the image and test your changes locally with the following command:

    $ docker build -t my-build-yocto-genivi .

Please consult `man docker` for details.

## Running the Docker image

A few use-cases are possible and described below.

Prerequisite: A Docker machine is installed, and the **build-yocto-genivi** image has been pulled.

### Setting up a scratch development environment inside a container

This command will create and start a new container

    $ docker run -ti gmacario/build-yocto-genivi

As a result a new Docker container will be created and you will be logged as user `build` into it:

```
gmacario@mv-linux-powerhorse:~⟫ docker run -ti gmacario/build-yocto-genivi
build@8f58c7795ca9:~$
```

Notice that in absence of the `--volume <hostdir>:/home/build` option to `docker run`, the build results will be stored inside the container, therefore they will disappear when the container is removed.

### Setting up an interactive development environment for YGB and GDP

Change to a empty directory with at least 50 GB disk space, then type the following command:

    $ docker run -ti \
      --volume $PWD:/home/build \
      gmacario/build-yocto-genivi

The `--volume <hostdir>:/home/build` option is used to prevent the Yocto build directory to fill in the partition where Docker creates the containers, as well as for preserving the build directory after the container is destroyed.

As a result a new Docker container will be created and you will be logged as user `build` into it:

```
gmacario@mv-linux-powerhorse:~/test⟫ docker run -ti \
>       --volume $PWD:/home/build \
>       gmacario/build-yocto-genivi
build@9be124a40754:~$
```

You may now follow the instructions inside the GENIVI wiki for building:

* Yocto GENIVI Baseline
* GENIVI Demo Platform

Or use the `/usr/local/bin/clone-and-build-gdp.sh` script as explained in the following section.

### Building GDP from sources

The Docker image contains a sample `clone-and-build-gdp.sh` script which may be run to clone the GDP sources from the GENIVI git repository, then perform a full build of the GDP image.

To perform a complete build of the GDP, change to a empty directory with at least 50 GB disk space, then type the following command:

    $ docker run -ti --volume $PWD:/home/build gmacario/build-yocto-genivi
    
Then when logged as `build@<container>` run the helper script:

    build@0b7eaf86c65d:~$ /usr/local/bin/clone-and-build-gdp.sh

Sample result:

```
gmacario@mv-linux-powerhorse:~/test⟫ docker run -ti --volume $PWD:/home/build test/build-yocto-genivi
build@0b7eaf86c65d:~$ /usr/local/bin/clone-and-build-gdp.sh
+ set -e
+ GDP_URL=git://git.projects.genivi.org/genivi-demo-platform.git
+ GDP_BRANCH=qemux86-64
+ WORKDIR=genivi-demo-platform
+ git config --global user.name easy-build
++ whoami
++ hostname
+ git config --global user.email build@0b7eaf86c65d
+ '[' '!' -e genivi-demo-platform ']'
+ cd genivi-demo-platform
+ git fetch --all --prune
Fetching origin
+ source init.sh
+++ basename /usr/local/bin/clone-and-build-gdp.sh
++ cmd=clone-and-build-gdp.sh
++ '[' clone-and-build-gdp.sh = init.sh ']'
++ git submodule init
++ git submodule sync
Synchronizing submodule url for 'meta-genivi-demo'
Synchronizing submodule url for 'meta-ivi'
Synchronizing submodule url for 'meta-openembedded'
Synchronizing submodule url for 'meta-qt5'
Synchronizing submodule url for 'poky'
++ git submodule update
++ source poky/oe-init-build-env gdp-src-build
+++ '[' -n poky/oe-init-build-env ']'
++++ dirname poky/oe-init-build-env
+++ OEROOT=poky
+++ '[' -n '' ']'
+++ THIS_SCRIPT=poky/oe-init-build-env
+++ '[' -z '' ']'
+++ '[' /usr/local/bin/clone-and-build-gdp.sh = poky/oe-init-build-env ']'
++++ readlink -f poky
+++ OEROOT=/home/build/genivi-demo-platform/poky
+++ export OEROOT
+++ . /home/build/genivi-demo-platform/poky/scripts/oe-buildenv-internal
++++ '[' -z /home/build/genivi-demo-platform/poky ']'
++++ '[' '!' -z '' ']'
+++++ /usr/bin/env python --version
+++++ grep 'Python 3'
++++ py_v3_check=
++++ '[' '' '!=' '' ']'
+++++ python -c 'import sys; print sys.version_info >= (2,7,3)'
++++ py_v26_check=True
++++ '[' True '!=' True ']'
++++ '[' x = x ']'
++++ BITBAKEDIR=/home/build/genivi-demo-platform/poky/bitbake/
+++++ readlink -f /home/build/genivi-demo-platform/poky/bitbake/
++++ BITBAKEDIR=/home/build/genivi-demo-platform/poky/bitbake
+++++ readlink -f /home/build/genivi-demo-platform/gdp-src-build
++++ BUILDDIR=/home/build/genivi-demo-platform/gdp-src-build
++++ test -d /home/build/genivi-demo-platform/poky/bitbake
++++ NEWPATHS=/home/build/genivi-demo-platform/poky/scripts:/home/build/genivi-demo-platform/poky/bitbake/bin:
+++++ echo /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
+++++ sed -e 's|:/home/build/genivi-demo-platform/poky/scripts:/home/build/genivi-demo-platform/poky/bitbake/bin:|:|g' -e 's|^/home/build/genivi-demo-platform/poky/scripts:/home/build/genivi-demo-platform/poky/bitbake/bin:||'
++++ PATH=/home/build/genivi-demo-platform/poky/scripts:/home/build/genivi-demo-platform/poky/bitbake/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
++++ unset BITBAKEDIR NEWPATHS
++++ export BUILDDIR
++++ export PATH
++++ export 'BB_ENV_EXTRAWHITE=MACHINE DISTRO TCMODE TCLIBC HTTP_PROXY http_proxy HTTPS_PROXY https_proxy FTP_PROXY ftp_proxy FTPS_PROXY ftps_proxy ALL_PROXY all_proxy NO_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY SDKMACHINE BB_NUMBER_THREADS BB_NO_NETWORK PARALLEL_MAKE GIT_PROXY_COMMAND SOCKS5_PASSWD SOCKS5_USER SCREENDIR STAMPS_DIR'
++++ BB_ENV_EXTRAWHITE='MACHINE DISTRO TCMODE TCLIBC HTTP_PROXY http_proxy HTTPS_PROXY https_proxy FTP_PROXY ftp_proxy FTPS_PROXY ftps_proxy ALL_PROXY all_proxy NO_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY SDKMACHINE BB_NUMBER_THREADS BB_NO_NETWORK PARALLEL_MAKE GIT_PROXY_COMMAND SOCKS5_PASSWD SOCKS5_USER SCREENDIR STAMPS_DIR'
+++ /home/build/genivi-demo-platform/poky/scripts/oe-setup-builddir

### Shell environment set up for builds. ###

You can now run 'bitbake <target>'

Common targets are:
    core-image-minimal
    core-image-sato
    meta-toolchain
    adt-installer
    meta-ide-support

You can also run generated qemu images with a command like 'runqemu qemux86'
+++ '[' -n /home/build/genivi-demo-platform/gdp-src-build ']'
+++ cd /home/build/genivi-demo-platform/gdp-src-build
+++ unset OEROOT
+++ unset BBPATH
+++ unset THIS_SCRIPT
+++ '[' -z '' ']'
+++ '[' -f bitbake.lock ']'
+++ grep : bitbake.lock
+++ '[' 1 = 0 ']'
++ echo

++ echo 'Now run:  bitbake genivi-demo-platform'
Now run:  bitbake genivi-demo-platform
+ bitbake genivi-demo-platform
Loading cache: 100% |##############################################################################################| ETA:  00:00:00
Loaded 1996 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        = "1.24.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "x86_64-poky-linux"
MACHINE           = "qemux86-64"
DISTRO            = "poky-ivi-systemd"
DISTRO_VERSION    = "8.0.1"
TUNE_FEATURES     = "m64 core2"
TARGET_FPU        = ""
meta
meta-yocto
meta-yocto-bsp    = "(detachedfrom6d34267):6d34267e0a13e10ab91b60590b27a2b5ba3b7da6"
meta-ivi
meta-ivi-bsp      = "(detachedfromcc64f96):cc64f96b285e64524d7e0c740155851bbc44d790"
meta-oe
meta-ruby         = "(detachedfrom6413cdb):6413cdb66acf43059f94d0076ec9b8ad6a475b35"
meta-qt5          = "(detachedfromadeca0d):adeca0db212d61a933d7952ad44ea1064cfca747"
meta-genivi-demo  = "(detachedfrome0c9fe6):e0c9fe684d84de9831d2b5612570c552c8bf7be1"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
NOTE: Tasks Summary: Attempted 4431 tasks of which 4431 didn't need to be rerun and all succeeded.
build@0b7eaf86c65d:~$
```

Notice that the first time the command is invoked on an empty directory, it may take several hours for the command to complete.

You may now terminate the container and return to the host by typing

```
build@0b7eaf86c65d:~$ exit
exit
gmacario@mv-linux-powerhorse:~/test⟫
```

As the `--volume $PWD:/home/build` option used when invoking `docker run`, the build results will directly be accessible from the host:

```
gmacario@mv-linux-powerhorse:~/test⟫ ls -la genivi-demo-platform/gdp-src-build/tmp/deploy/images/qemux86-64/
total 912980
drwxr-xr-x 2 gmacario gmacario      4096 Jan 19 22:51 .
drwxr-xr-x 3 gmacario gmacario      4096 Jan 19 18:25 ..
lrwxrwxrwx 1 gmacario gmacario        76 Jan 19 18:25 bzImage -> bzImage--3.14.29+git0+6eddbf4787_21ba402e0a-r0-qemux86-64-20160119143635.bin
-rw-r--r-- 2 gmacario gmacario   6620496 Jan 19 18:25 bzImage--3.14.29+git0+6eddbf4787_21ba402e0a-r0-qemux86-64-20160119143635.bin
lrwxrwxrwx 1 gmacario gmacario        76 Jan 19 18:25 bzImage-qemux86-64.bin -> bzImage--3.14.29+git0+6eddbf4787_21ba402e0a-r0-qemux86-64-20160119143635.bin
-rw-r--r-- 1 gmacario gmacario 832634880 Jan 19 22:50 genivi-demo-platform-qemux86-64-20160119143635.rootfs.ext3
-rw-r--r-- 1 gmacario gmacario     43243 Jan 19 22:49 genivi-demo-platform-qemux86-64-20160119143635.rootfs.manifest
-rw-r--r-- 1 gmacario gmacario 184680306 Jan 19 22:50 genivi-demo-platform-qemux86-64-20160119143635.rootfs.tar.bz2
lrwxrwxrwx 1 gmacario gmacario        58 Jan 19 22:51 genivi-demo-platform-qemux86-64.ext3 -> genivi-demo-platform-qemux86-64-20160119143635.rootfs.ext3
lrwxrwxrwx 1 gmacario gmacario        62 Jan 19 22:51 genivi-demo-platform-qemux86-64.manifest -> genivi-demo-platform-qemux86-64-20160119143635.rootfs.manifest
lrwxrwxrwx 1 gmacario gmacario        61 Jan 19 22:51 genivi-demo-platform-qemux86-64.tar.bz2 -> genivi-demo-platform-qemux86-64-20160119143635.rootfs.tar.bz2
-rw-r--r-- 2 gmacario gmacario  70076612 Jan 19 18:25 modules--3.14.29+git0+6eddbf4787_21ba402e0a-r0-qemux86-64-20160119143635.tgz
lrwxrwxrwx 1 gmacario gmacario        76 Jan 19 18:25 modules-qemux86-64.tgz -> modules--3.14.29+git0+6eddbf4787_21ba402e0a-r0-qemux86-64-20160119143635.tgz
-rw-r--r-- 2 gmacario gmacario       294 Jan 19 22:42 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
gmacario@mv-linux-powerhorse:~/test⟫
```

## Troubleshooting

In case the build fails, inside the interactive development environment you may try to clean the offending tasks, as in the following example:

    $ bitbake -c cleansstate cairo

then invoke `bitbake <package>` again.

<!-- EOF -->
