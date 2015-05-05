# build-yocto-genivi

build-yocto-genivi is a subproject of [easy-build](https://github.com/gmacario/easy-build)
and has the objective of providing a simplified environment where to rebuild from sources
the [GENIVI Yocto Baseline](http://projects.genivi.org/GENIVI_Baselines/meta-ivi/home),
as well as running it on virtual targets such as QEMU, VirtualBox or VMware.

build-yocto-genivi relies on [Docker](http://www.docker.com/) and creates a clean,
stand-alone development environment complete with all the tools needed to perform
a full build of the target image.

## Getting the Docker image locally

Several options are possible here.

### Pulling image from index.docker.io

The most recent builds of the build-yocto-genivi project are published
on [Docker Hub](https://hub.docker.com/):

    $ docker pull gmacario/build-yocto-genivi

### Creating the image using the build.sh script

Alternatively you may do a local rebuild of your Docker image following to the instructions
inside the `Dockerfile`.  You may do so through the following command

    $ ./build.sh
    
**NOTE**: If the script appears to hang, please either delete or move the contents
of the `shared/` subdirectory before launching the script.

### Creating the image from the Dockerfile

This is basically what the `build.sh` script does, but you may customize the Docker image
or add other configuration options (please consult `man docker` for details)

    $ docker build -t my-build-yocto-genivi .
    
## Running the Docker image

Prerequisite: the Docker image is already available locally.

As before, several options are possible.

### Using the run.sh script (quick)

This command will execute faster in case the container has already run previously.

    $ ./run.sh

### Invoking Docker manually

This command will create and start a new container

    $ docker run -t -i -v <shareddir>:/home/build/shared gmacario/build-yocto-genivi

The `-v <shareddir>:/home/build/shared` options instructs Docker to have the `/home/build/shared`
directory of the container mapped to a directory of the host filesystem. 
This may be used to prevent the Yocto build directory to fill in the partition where containers
are created, as well as for preserving the build directory after the container is destroyed.

## Using build-yocto-genivi

Adapted from [meta-ivi README.md](http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md)

Prerequisite: the container is already running.

### Preparation

    # Make sure that /dev/shm is writable
    chmod a+w /dev/shm
    
    # Make sure that ~build/shared directory is owned by user "build"
    chown build.build ~build/shared
    
    # Switch to user 'build'
    su - build

### Initialize build environment

After logging in as user "build" execute the following commands:

    $ export GENIVI=~/genivi-baseline
    $ source ${GENIVI}/poky/oe-init-build-env ~/shared/my-genivi-build
    $ export TOPDIR=${PWD}

### Building the GENIVI image

#### Configure the build

Review script `configure_build.sh` and make any modifications if needed, then invoke the script

    $ sh ~/configure_build.sh

For help about syntax of `conf/bblayers.conf` and `conf/local.conf` please refer to the
[Yocto Project Documentation](http://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html).

#### Perform the build

    $ cd ${TOPDIR}
    $ bitbake -k <genivi_release>-image

The actual command depends on which GENIVI release you are targeting at.

**NOTE**: This command may take a few hours to complete.

##### Example for meta-ivi 8.0.x (Jupiter)

Command:

    $ cd ${TOPDIR}
    $ bitbake -k jupiter-image

Result (for meta-ivi 8.0):

```
build@50e2c65e266d:~/shared/my-genivi-build$ bitbake -k jupiter-image
Loading cache: 100% |#############################################################################| ETA:  00:00:00
Loaded 1887 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        = "1.24.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "i586-poky-linux"
MACHINE           = "qemux86"
DISTRO            = "poky-ivi-systemd"
DISTRO_VERSION    = "8.0.0"
TUNE_FEATURES     = "m32 i586"
TARGET_FPU        = ""
meta
meta-yocto
meta-yocto-bsp    = "(detachedfrom6dd21a9):6dd21a9f152a93e2df1178d7a5bd903d7edcf4be"
meta-ivi
meta-ivi-bsp      = "8.0:3a619f09239276dafca21f521fdbffae226b6e0e"
meta-oe           = "(detachedfrom853dcfa):853dcfa0d618dc26bd27b3a1b49494b98d6eee97"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
WARNING: Failed to fetch URL http://zlib.net/pigz/pigz-2.3.1.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/b/base-passwd/base-passwd_3.5.29.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://downloads.sourceforge.net/project/libpng/libpng16/1.6.13/libpng-1.6.13.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/apr/apr-util-1.5.3.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://ftp.gnome.org/pub/GNOME/sources/gnome-common/3.12/gnome-common-3.12.0.tar.xz;name=archive, attempting MIRRORS if available
WARNING: Checksum failure encountered with download of http://avahi.org/download/avahi-0.6.31.tar.gz - will attempt other sources if available
WARNING: Renaming /home/build/shared/my-genivi-build/downloads/avahi-0.6.31.tar.gz to /home/build/shared/my-genivi-build/downloads/avahi-0.6.31.tar.gz_bad-checksum_5fea92ab9e5697fb8f146319b6120b3a
WARNING: Failed to fetch URL http://www.apache.org/dist/subversion/subversion-1.8.9.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/n/netbase/netbase_5.2.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/d/dpkg/dpkg_1.17.4.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://ftp.de.debian.org/debian/pool/main/m/mklibs/mklibs_0.1.39.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://createrepo.baseurl.org/download/createrepo-0.4.11.tar.gz, attempting MIRRORS if available
NOTE: validating kernel config, see log.do_kernel_configcheck for details
WARNING: QA Issue: coreutils: configure was passed unrecognised options: --disable-acl [unknown-configure-option]
WARNING: QA Issue: mesa: configure was passed unrecognised options: --with-llvm-shared-libs [unknown-configure-option]
WARNING: QA Issue: coreutils rdepends on libacl, but it isn't a build dependency? [build-deps]
WARNING: QA Issue: ELF binary '/home/build/shared/my-genivi-build/tmp/work/i586-poky-linux/wayland-ivi-extension/1.3.0-r0/packages-split/wayland-ivi-extension/usr/lib/weston/ivi-controller.so' has relocations in .text [textrel]
WARNING: QA Issue: pulseaudio-module-console-kit rdepends on consolekit, but it isn't a build dependency? [build-deps]
NOTE: Tasks Summary: Attempted 3179 tasks of which 15 didn't need to be rerun and all succeeded.

Summary: There were 17 WARNING messages shown.
build@50e2c65e266d:~/shared/my-genivi-build$
```

As a result of the build the following files will be created:

```
build@50e2c65e266d:~/shared/my-genivi-build$ ls -la tmp/deploy/images/qemux86/
total 317740
drwxrwxr-x 2 build build      4096 Mar 19 14:06 .
drwxrwxr-x 3 build build      4096 Mar 19 13:33 ..
-rw-r--r-- 2 build build       294 Mar 19 14:01 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
lrwxrwxrwx 1 build build        73 Mar 19 13:33 bzImage -> bzImage--3.14.24+git0+a227f20eff_38cd560d50-r0-qemux86-20150319110225.bin
-rw-r--r-- 2 build build   6643952 Mar 19 13:33 bzImage--3.14.24+git0+a227f20eff_38cd560d50-r0-qemux86-20150319110225.bin
lrwxrwxrwx 1 build build        73 Mar 19 13:33 bzImage-qemux86.bin -> bzImage--3.14.24+git0+a227f20eff_38cd560d50-r0-qemux86-20150319110225.bin
-rw-r--r-- 1 build build 281374720 Mar 19 14:05 jupiter-image-qemux86-20150319110225.rootfs.ext3
-rw-r--r-- 1 build build     33594 Mar 19 14:05 jupiter-image-qemux86-20150319110225.rootfs.manifest
-rw-r--r-- 1 build build  55339655 Mar 19 14:05 jupiter-image-qemux86-20150319110225.rootfs.tar.bz2
lrwxrwxrwx 1 build build        48 Mar 19 14:06 jupiter-image-qemux86.ext3 -> jupiter-image-qemux86-20150319110225.rootfs.ext3
lrwxrwxrwx 1 build build        52 Mar 19 14:06 jupiter-image-qemux86.manifest -> jupiter-image-qemux86-20150319110225.rootfs.manifest
lrwxrwxrwx 1 build build        51 Mar 19 14:06 jupiter-image-qemux86.tar.bz2 -> jupiter-image-qemux86-20150319110225.rootfs.tar.bz2
-rw-rw-r-- 2 build build  76208922 Mar 19 13:33 modules--3.14.24+git0+a227f20eff_38cd560d50-r0-qemux86-20150319110225.tgz
lrwxrwxrwx 1 build build        73 Mar 19 13:33 modules-qemux86.tgz -> modules--3.14.24+git0+a227f20eff_38cd560d50-r0-qemux86-20150319110225.tgz
build@50e2c65e266d:~/shared/my-genivi-build$
```

#### Example for meta-ivi 7.0.x (Intrepid)

Command:

    $ cd ${TOPDIR}
    $ bitbake -k intrepid-image

Sample output:

```
build@f49b57277afb:~/shared/my-genivi-build$ bitbake -k intrepid-image
Parsing recipes: 100% |###########################################################################| Time: 00:00:43
Parsing of 1436 .bb files complete (0 cached, 1436 parsed). 1883 targets, 216 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        = "1.24.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "i586-poky-linux"
MACHINE           = "qemux86"
DISTRO            = "poky-ivi-systemd"
DISTRO_VERSION    = "7.0.3"
TUNE_FEATURES     = "m32 i586"
TARGET_FPU        = ""
meta
meta-yocto
meta-yocto-bsp    = "(detachedfromdf87cb2):df87cb27efeaea1455f20692f9f1397c6fcab254"
meta-ivi
meta-ivi-bsp      = "(detachedfrom7.0.3):7cae90ffa290cb4ab0578174abfebce5579cac48"
meta-oe           = "(detachedfrom9efaed9):9efaed99125b1c4324663d9a1b2d3319c74e7278"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
WARNING: Failed to fetch URL http://zlib.net/pigz/pigz-2.3.1.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/b/base-passwd/base-passwd_3.5.29.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://downloads.sourceforge.net/project/libpng/libpng16/1.6.13/libpng-1.6.13.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/apr/apr-util-1.5.3.tar.gz, attempting MIRRORS if available
WARNING: Checksum failure encountered with download of http://avahi.org/download/avahi-0.6.31.tar.gz - will attempt other sources if available
WARNING: Renaming /home/build/shared/my-genivi-build/downloads/avahi-0.6.31.tar.gz to /home/build/shared/my-genivi-build/downloads/avahi-0.6.31.tar.gz_bad-checksum_5fea92ab9e5697fb8f146319b6120b3a
WARNING: Failed to fetch URL http://www.apache.org/dist/subversion/subversion-1.8.9.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/n/netbase/netbase_5.2.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/d/dpkg/dpkg_1.17.4.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://ftp.de.debian.org/debian/pool/main/m/mklibs/mklibs_0.1.39.tar.xz, attempting MIRRORS if available
NOTE: validating kernel config, see log.do_kernel_configcheck for details
WARNING: QA Issue: coreutils: configure was passed unrecognised options: --disable-acl [unknown-configure-option]
WARNING: QA Issue: mesa: configure was passed unrecognised options: --with-llvm-shared-libs [unknown-configure-option]
WARNING: QA Issue: ELF binary '/home/build/shared/my-genivi-build/tmp/work/i586-poky-linux/wayland-ivi-extension/1.2.0-r0/packages-split/wayland-ivi-extension/usr/lib/weston/ivi-controller.so' has relocations in .text [textrel]
WARNING: QA Issue: pulseaudio-module-console-kit rdepends on consolekit, but it isn't a build dependency? [build-deps]
WARNING: QA Issue: coreutils rdepends on libacl, but it isn't a build dependency? [build-deps]
NOTE: Tasks Summary: Attempted 3194 tasks of which 26 didn't need to be rerun and all succeeded.

Summary: There were 15 WARNING messages shown.
build@f49b57277afb:~/shared/my-genivi-build$
```

As a result of the build the following files will be created:

```
build@f49b57277afb:~/shared/my-genivi-build$ ls -la tmp/deploy/images/qemux86/
total 317448
drwxrwxr-x 2 build build      4096 Mar 13 11:49 .
drwxrwxr-x 3 build build      4096 Mar 13 11:21 ..
-rw-r--r-- 2 build build       294 Mar 13 11:44 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
lrwxrwxrwx 1 build build        73 Mar 13 11:21 bzImage -> bzImage--3.14.19+git0+fb6271a942_e19a1b40de-r0-qemux86-20150313083745.bin
-rw-r--r-- 2 build build   6636528 Mar 13 11:20 bzImage--3.14.19+git0+fb6271a942_e19a1b40de-r0-qemux86-20150313083745.bin
lrwxrwxrwx 1 build build        73 Mar 13 11:21 bzImage-qemux86.bin -> bzImage--3.14.19+git0+fb6271a942_e19a1b40de-r0-qemux86-20150313083745.bin
-rw-r--r-- 1 build build 281150464 Mar 13 11:48 intrepid-image-qemux86-20150313083745.rootfs.ext3
-rw-r--r-- 1 build build     33564 Mar 13 11:48 intrepid-image-qemux86-20150313083745.rootfs.manifest
-rw-r--r-- 1 build build  55350267 Mar 13 11:48 intrepid-image-qemux86-20150313083745.rootfs.tar.bz2
lrwxrwxrwx 1 build build        49 Mar 13 11:49 intrepid-image-qemux86.ext3 -> intrepid-image-qemux86-20150313083745.rootfs.ext3
lrwxrwxrwx 1 build build        53 Mar 13 11:49 intrepid-image-qemux86.manifest -> intrepid-image-qemux86-20150313083745.rootfs.manifest
lrwxrwxrwx 1 build build        52 Mar 13 11:49 intrepid-image-qemux86.tar.bz2 -> intrepid-image-qemux86-20150313083745.rootfs.tar.bz2
-rw-rw-r-- 2 build build  76114738 Mar 13 11:21 modules--3.14.19+git0+fb6271a942_e19a1b40de-r0-qemux86-20150313083745.tgz
lrwxrwxrwx 1 build build        73 Mar 13 11:21 modules-qemux86.tgz -> modules--3.14.19+git0+fb6271a942_e19a1b40de-r0-qemux86-20150313083745.tgz
build@f49b57277afb:~/shared/my-genivi-build$
```

#### Building the GENIVI Demo Platform image

**NOTE**: Instructions are still to be validated

Prerequisite: Create and run the container, then logged as user "build"

```
$ cd ~/shared
```

Fetch the `configure_build_gdp.sh` inside the container if you haven't one already:

```
$ if [ ! -x configure_build_gdp.sh ]; then curl -O \
https://raw.githubusercontent.com/gmacario/easy-build/master/build-yocto-genivi/configure_build_gdp.sh; \
chmod 755 configure_build_gdp.sh; fi
```

Run the `configure_build_gdp.sh` once to clone/pull the source repositories:

```
$ ~/shared/configure_build_gdp.sh
```

Then create the build directory and run the script again to customize the build configuration:

```
$ source ~/shared/sources/poky/oe-init-build-env ~/shared/my-gdp-build04
$ ~/shared/configure_build_gdp.sh
```

You may now start the build of the GDP with the following command

```
$ bitbake -k genivi-demo-platform
```

Result:

```
Missing or unbuildable dependency chain was: ['qt4-examples-dbg', 'virtual/libx11']
NOTE: Runtime target 'qt4-linguist-dbg' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['qt4-linguist-dbg', 'virtual/libx11']
NOTE: Runtime target 'qt4-makeqpf-dbg' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['qt4-makeqpf-dbg', 'virtual/libx11']
NOTE: Runtime target 'qt4-mkspecs-dbg' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['qt4-mkspecs-dbg', 'virtual/libx11']
NOTE: Runtime target 'qt4-pixeltool-dbg' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['qt4-pixeltool-dbg', 'virtual/libx11']
NOTE: Runtime target 'qt4-qmlviewer-dbg' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['qt4-qmlviewer-dbg', 'virtual/libx11']
NOTE: Runtime target 'qt4-xmlpatterns-dbg' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['qt4-xmlpatterns-dbg', 'virtual/libx11']
NOTE: Runtime target 'qt4-qt3to4-dbg' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['qt4-qt3to4-dbg', 'virtual/libx11']
NOTE: Runtime target 'qt4-qml-plugins-dbg' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['qt4-qml-plugins-dbg', 'virtual/libx11']
NOTE: Runtime target 'libqtpvrqwswsegl4-dbg' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['libqtpvrqwswsegl4-dbg', 'virtual/libx11']
ERROR: Nothing PROVIDES 'libxft' (but /home/build/shared/sources/poky/meta/recipes-qt/qt4/qt4-x11-free_4.8.6.bb DEPENDS on or otherwise requires it)
ERROR: libxft was skipped: missing required distro feature 'x11' (not in DISTRO_FEATURES)
ERROR: Nothing PROVIDES 'libxext' (but /home/build/shared/sources/poky/meta/recipes-qt/qt4/qt4-x11-free_4.8.6.bb DEPENDS on or otherwise requires it)
ERROR: libxext was skipped: missing required distro feature 'x11' (not in DISTRO_FEATURES)
ERROR: libxext was skipped: missing required distro feature 'x11' (not in DISTRO_FEATURES)
ERROR: Nothing PROVIDES 'libxrender' (but /home/build/shared/sources/poky/meta/recipes-qt/qt4/qt4-x11-free_4.8.6.bb DEPENDS on or otherwise requires it)
ERROR: libxrender was skipped: missing required distro feature 'x11' (not in DISTRO_FEATURES)
ERROR: Nothing PROVIDES 'libxrandr' (but /home/build/shared/sources/poky/meta/recipes-qt/qt4/qt4-x11-free_4.8.6.bb DEPENDS on or otherwise requires it)
ERROR: libxrandr was skipped: missing required distro feature 'x11' (not in DISTRO_FEATURES)
ERROR: Nothing PROVIDES 'libxcursor' (but /home/build/shared/sources/poky/meta/recipes-qt/qt4/qt4-x11-free_4.8.6.bb DEPENDS on or otherwise requires it)
ERROR: libxcursor was skipped: missing required distro feature 'x11' (not in DISTRO_FEATURES)
 
Build Configuration:
BB_VERSION        = "1.24.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "x86_64-poky-linux"
MACHINE           = "qemux86-64"
DISTRO            = "poky-ivi-systemd"
DISTRO_VERSION    = "7.0.3"
TUNE_FEATURES     = "m64 core2"
TARGET_FPU        = ""
meta
meta-yocto
meta-yocto-bsp    = "dizzy:29812e61736a95f1de64b3e9ebbb9c646ebd28dd"
meta-ivi
meta-ivi-bsp      = "7.0:0d780d0cfd38694ae5e6f0198adcb72684b01acc"
meta-oe           = "dizzy:5b6f39ce325d490fc382d5d59c5b8b9d5fa38b38"
meta-genivi-demo  = "master:b1980ff6fefed9957513ce0a57f6926c76421324"
meta-qt5          = "dizzy:adeca0db212d61a933d7952ad44ea1064cfca747"
meta-ruby         = "dizzy:5b6f39ce325d490fc382d5d59c5b8b9d5fa38b38"
meta-renesas      = "genivi-7.0-bsp-1.8.0:6e829fe6e422793bbb05ec563c8544154c0e9bd8"
 
NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
NOTE: validating kernel config, see log.do_kernel_configcheck for details
WARNING: QA Issue: mesa: configure was passed unrecognised options: --with-llvm-shared-libs [unknown-configure-option]
WARNING: QA Issue: ELF binary '/home/build/shared/my-gdp-build04/tmp/work/core2-64-poky-linux/wayland-ivi-extension/1.3.0-r0/packages-split/wayland-ivi-extension/usr/lib/weston/ivi-controller.so' has relocations in .text [textrel]
WARNING: QA Issue: pulseaudio-module-console-kit rdepends on consolekit, but it isn't a build dependency? [build-deps]
NOTE: Tasks Summary: Attempted 4166 tasks of which 22 didn't need to be rerun and all succeeded.
 
Summary: There were 3 WARNING messages shown.
Summary: There were 6 ERROR messages shown, returning a non-zero exit code.
build@4f3caf384331:~/shared/my-gdp-build04$
```

The following files will be created under `tmp/deploy/images/<MACHINE>`:

```
build@4f3caf384331:~/shared/my-gdp-build04$ ls -la tmp/deploy/images/qemux86-64/
total 893664
drwxrwxr-x 2 build build      4096 Apr 30 16:26 .
drwxrwxr-x 3 build build      4096 Apr 30 12:22 ..
-rw-r--r-- 2 build build       294 Apr 30 16:18 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
lrwxrwxrwx 1 build build        76 Apr 30 12:22 bzImage -> bzImage--3.14.29+git0+6eddbf4787_21ba402e0a-r0-qemux86-64-20150430090259.bin
-rw-r--r-- 2 build build   6621136 Apr 30 12:21 bzImage--3.14.29+git0+6eddbf4787_21ba402e0a-r0-qemux86-64-20150430090259.bin
lrwxrwxrwx 1 build build        76 Apr 30 12:22 bzImage-qemux86-64.bin -> bzImage--3.14.29+git0+6eddbf4787_21ba402e0a-r0-qemux86-64-20150430090259.bin
-rw-r--r-- 1 build build 814094336 Apr 30 16:25 genivi-demo-platform-qemux86-64-20150430090259.rootfs.ext3
-rw-r--r-- 1 build build     43146 Apr 30 16:24 genivi-demo-platform-qemux86-64-20150430090259.rootfs.manifest
-rw-r--r-- 1 build build 180343648 Apr 30 16:25 genivi-demo-platform-qemux86-64-20150430090259.rootfs.tar.bz2
lrwxrwxrwx 1 build build        58 Apr 30 16:26 genivi-demo-platform-qemux86-64.ext3 -> genivi-demo-platform-qemux86-64-20150430090259.rootfs.ext3
lrwxrwxrwx 1 build build        62 Apr 30 16:26 genivi-demo-platform-qemux86-64.manifest -> genivi-demo-platform-qemux86-64-20150430090259.rootfs.manifest
lrwxrwxrwx 1 build build        61 Apr 30 16:26 genivi-demo-platform-qemux86-64.tar.bz2 -> genivi-demo-platform-qemux86-64-20150430090259.rootfs.tar.bz2
-rw-rw-r-- 2 build build  70074601 Apr 30 12:22 modules--3.14.29+git0+6eddbf4787_21ba402e0a-r0-qemux86-64-20150430090259.tgz
lrwxrwxrwx 1 build build        76 Apr 30 12:22 modules-qemux86-64.tgz -> modules--3.14.29+git0+6eddbf4787_21ba402e0a-r0-qemux86-64-20150430090259.tgz
build@4f3caf384331:~/shared/my-gdp-build04$
```

#### Troubleshooting

In case the build fails you may try to clean the offending tasks, as in the following example:

    $ bitbake -c cleansstate cairo
    
then invoke `bitbake <genivi_release>-image` again.

## (Optional) Committing the image after building the Yocto GENIVI Baseline

If the previous commands were successful, exit the container, then execute
the following commands to persist the container into a Docker image:

    $ CONTAINER_ID=$(docker ps -lq)
    $ docker commit -m "John Doe <john.doe@me.com>" ${CONTAINER_ID} <repository:tag>

You may optionally push the image to a public Docker repository, like

    $ docker push <repository>

## Creating standalone images for execution under QEMU, VirtualBox and VMware Player

This works only for `MACHINE=qemux86`

Review the `create_standalone_images.sh` script to adjust the configurable parameters, then run

    $ ./create_standalone_images.sh

Follow the instructions displayed by the script for loading and running the images under:

* [qemu-system-i386](http://www.qemu.org/) (tested with qemu-kvm 1.0 on Ubuntu 12.04.4 LTS)
* [Oracle VM VirtualBox](https://www.virtualbox.org/) (tested with VirtualBox 4.3.10 on MS Windows 7 and Ubuntu 12.04.4 LTS)
* [VMware Player](http://www.vmware.com/products/player) (tested with VMware Player 6.0.1 on MS Windows 7)

<!-- EOF -->
