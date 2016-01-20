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

As a result you will be logged into the container as user `build`

```
TODO
```

Notice that in absence of the `--volume <hostdir>:/home/build` option, the result of the build are stored inside the container and will disappear when the container is removed.

The `--volume <hostdir>:/home/build` option is used to prevent the Yocto build directory to fill in the partition where Docker creates the containers, as well as for preserving the build directory after the container is destroyed.

### Setting up an interactive development environment for YGB and GDP

    $ docker run -ti \
      --volume $PWD:/home/build \
      test/build-yocto-genivi

As a result you will be logged into the container as user `build`

```
gmacario@mv-linux-powerhorse:~/test⟫ docker run -ti \
>       --volume $PWD:/home/build \
>       test/build-yocto-genivi
build@9be124a40754:~$
```

You may now execute `/usr/local/bin/clone-and-build-gdp.sh`, or follow the instructions inside the GENIVI wiki for building:

* Yocto GENIVI Baseline
* GENIVI Demo Platform

### Building GDP non-interactively

The Docker image contains a sample `clone-and-build-gdp.sh` which may be run to clone the GDP sources from git.projects.genivi.org and perform a full build of the GDP image.

You may perform the build running the following command:

    $ docker run -ti \
      --volume $PWD:/home/build \
      test/build-yocto-genivi
      /usr/local/bin/clone-and-build-gdp.sh

Sample result:

```
gmacario@mv-linux-powerhorse:~/test⟫ docker run -ti \
>       --volume $PWD:/home/build \
>       test/build-yocto-genivi
      /usr/local/bin/clone-and-build-gdp.sh
      /usr/local/bin/clone-and-build-gdp.sh
build@2c61b74cac79:~$       /usr/local/bin/clone-and-build-gdp.sh
+ set -e
+ GDP_URL=git://git.projects.genivi.org/genivi-demo-platform.git
+ GDP_BRANCH=qemux86-64
+ WORKDIR=genivi-demo-platform
+ git config --global user.name easy-build
++ whoami
++ hostname
+ git config --global user.email build@2c61b74cac79
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
...
++ echo 'Now run:  bitbake genivi-demo-platform'
Now run:  bitbake genivi-demo-platform
+ bitbake genivi-demo-platform
Parsing recipes: 100% |############################################################################################| Time: 00:00:51
Parsing of 1547 .bb files complete (0 cached, 1547 parsed). 1995 targets, 167 skipped, 0 masked, 0 errors.
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
WARNING: Failed to fetch URL http://zlib.net/pigz/pigz-2.3.1.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/b/base-passwd/base-passwd_3.5.29.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://downloads.sourceforge.net/project/libpng/libpng16/1.6.13/libpng-1.6.13.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.freedesktop.org/pub/mesa/10.1.3/MesaLib-10.1.3.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/apr/apr-1.5.1.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/apr/apr-util-1.5.3.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/subversion/subversion-1.8.9.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL http://code.entropywave.com/download/orc/orc-0.4.18.tar.gz;name=orc, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.cpan.org/authors/id/D/DM/DMEGG/SGMLSpm-1.03ii.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://downloads.sourceforge.net/fuse/fuse-2.9.3.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/n/netbase/netbase_5.2.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/d/dpkg/dpkg_1.17.4.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://ftp.de.debian.org/debian/pool/main/m/mklibs/mklibs_0.1.39.tar.xz, attempting MIRRORS if available
NOTE: validating kernel config, see log.do_kernel_configcheck for details
WARNING: QA Issue: ELF binary '/home/build/genivi-demo-platform/gdp-src-build/tmp/work/core2-64-poky-linux/wayland-ivi-extension/1.3.0-r0/packages-split/wayland-ivi-extension/usr/lib/weston/ivi-controller.so' has relocations in .text [textrel]
WARNING: QA Issue: pulseaudio-module-console-kit rdepends on consolekit, but it isn't a build dependency? [build-deps]
NOTE: Tasks Summary: Attempted 4431 tasks of which 22 didn't need to be rerun and all succeeded.

Summary: There were 15 WARNING messages shown.
gmacario@mv-linux-powerhorse:~/test⟫
```

Thanks to the `--volume $PWD:/home/build` option used when invoking `docker run`, the build results will directly be accessible from the host:

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
