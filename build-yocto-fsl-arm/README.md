build-yocto-fsl-arm
===================

This subproject of easy-build provides a quick and easy way
for creating embedded Linux distributions for Freescale/ARM targets
using the [Yocto project](http://www.yoctoproject.arm) tools.

## Building container

    ./build.sh

## Running container

    ./run.sh

## Building the image for the Freescale SabreSD (i.MX6 Quad)

Precondition: logged into the container.

Create an environment variable

    export YOCTO=/opt/yocto

Configure SHA for each layer

    #TODO

Create the build environment (notice the workaround to allow $TOPDIR outside $YOCTO)

    cd $YOCTO/fsl-community-bsp
    ln -sf ~/shared/build-imx6qsabresd
    MACHINE=imx6qsabresd \
        source ./setup-environment \
        build-imx6qsabresd
        
Verify (and if necessary update) the build configuration under `conf/`

    #TODO
    
Workaround: allow bitbake to run as root

    touch conf/sanity.conf

Workaround: edit conf/bblayer.conf and replace BSPDIR definition with

    BSPDIR := "/opt/yocto/fsl-community-bsp"
    
### Start the build (core-image-sato)

    bitbake -k core-image-sato

Sample output:
```
root@041dc56cadf6:/shared/build-imx6qsabresd# bitbake -k core-image-sato
Parsing recipes: 100% |###############################################################| Time: 00:00:36
Parsing of 1393 .bb files complete (0 cached, 1393 parsed). 1819 targets, 99 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies
NOTE: multiple providers are available for jpeg (jpeg, libjpeg-turbo)
NOTE: consider defining a PREFERRED_PROVIDER entry to match jpeg
NOTE: multiple providers are available for jpeg-native (jpeg-native, libjpeg-turbo-native)
NOTE: consider defining a PREFERRED_PROVIDER entry to match jpeg-native

Build Configuration:
BB_VERSION        = "1.22.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "arm-poky-linux-gnueabi"
MACHINE           = "imx6qsabresd"
DISTRO            = "poky"
DISTRO_VERSION    = "1.6"
TUNE_FEATURES     = "armv7a vfp neon callconvention-hard cortexa9"
TARGET_FPU        = "vfp-neon"
meta
meta-yocto        = "(nobranch):62b1fef7875a6f9c55344fa6bcc7d4b6672eac1f"
meta-oe           = "(nobranch):dca466c074c9a35bc0133e7e0d65cca0731e2acf"
meta-fsl-arm      = "(nobranch):f5bf277a5a5fba2c3b64ed7d2dbec1903d96386b"
meta-fsl-arm-extra = "(nobranch):48cba7af1b94a60fbcbf4ac7bdb0edb3f40b4ae5"
meta-fsl-demos    = "(nobranch):27fdb2f2642ecd55d5633bde880dd4c37acd0d42"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
NOTE: Tasks Summary: Attempted 4731 tasks of which 29 didn't need to be rerun and all succeeded.
root@041dc56cadf6:/shared/build-imx6qsabresd#
```

If the build is successful, the following files will be created under `$TOPDIR/tmp/deploy/images/$MACHINE`
```
root@041dc56cadf6:/shared/build-imx6qsabresd# ls -la tmp/deploy/images/imx6qsabresd/
total 566600
drwxr-xr-x 2 root root      4096 Jun  9 11:36 .
drwxr-xr-x 3 root root      4096 Jun  9 10:16 ..
-rw-r--r-- 2 root root       294 Jun  9 11:34 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
-rw-r--r-- 1 root root 301989888 Jun  9 11:36 core-image-sato-imx6qsabresd-20140609091727.rootfs.ext3
-rw-r--r-- 1 root root     18150 Jun  9 11:35 core-image-sato-imx6qsabresd-20140609091727.rootfs.manifest
-rw-r--r-- 1 root root 318767104 Jun  9 11:36 core-image-sato-imx6qsabresd-20140609091727.rootfs.sdcard
-rw-r--r-- 1 root root  64865370 Jun  9 11:35 core-image-sato-imx6qsabresd-20140609091727.rootfs.tar.bz2
lrwxrwxrwx 1 root root        55 Jun  9 11:36 core-image-sato-imx6qsabresd.ext3 -> core-image-sato-imx6qsabresd-20140609091727.rootfs.ext3
lrwxrwxrwx 1 root root        59 Jun  9 11:36 core-image-sato-imx6qsabresd.manifest -> core-image-sato-imx6qsabresd-20140609091727.rootfs.manifest
lrwxrwxrwx 1 root root        57 Jun  9 11:36 core-image-sato-imx6qsabresd.sdcard -> core-image-sato-imx6qsabresd-20140609091727.rootfs.sdcard
lrwxrwxrwx 1 root root        58 Jun  9 11:36 core-image-sato-imx6qsabresd.tar.bz2 -> core-image-sato-imx6qsabresd-20140609091727.rootfs.tar.bz2
-rw-r--r-- 2 root root    597656 Jun  9 10:16 modules--3.10.17-r0-imx6qsabresd-20140609091727.tgz
lrwxrwxrwx 1 root root        51 Jun  9 10:16 modules-imx6qsabresd.tgz -> modules--3.10.17-r0-imx6qsabresd-20140609091727.tgz
-rwxr-xr-x 2 root root    314368 Jun  9 11:31 u-boot-imx6qsabresd-v2014.01-r0.imx
lrwxrwxrwx 1 root root        35 Jun  9 11:31 u-boot-imx6qsabresd.imx -> u-boot-imx6qsabresd-v2014.01-r0.imx
lrwxrwxrwx 1 root root        35 Jun  9 11:31 u-boot.imx -> u-boot-imx6qsabresd-v2014.01-r0.imx
lrwxrwxrwx 1 root root        50 Jun  9 10:16 uImage -> uImage--3.10.17-r0-imx6qsabresd-20140609091727.bin
-rw-r--r-- 2 root root     47179 Jun  9 10:16 uImage--3.10.17-r0-imx6q-sabresd-20140609091727.dtb
-rw-r--r-- 2 root root     47268 Jun  9 10:16 uImage--3.10.17-r0-imx6q-sabresd-hdcp-20140609091727.dtb
-rw-r--r-- 2 root root     47179 Jun  9 10:16 uImage--3.10.17-r0-imx6q-sabresd-ldo-20140609091727.dtb
-rw-r--r-- 2 root root   5264192 Jun  9 10:16 uImage--3.10.17-r0-imx6qsabresd-20140609091727.bin
lrwxrwxrwx 1 root root        56 Jun  9 10:16 uImage-imx6q-sabresd-hdcp.dtb -> uImage--3.10.17-r0-imx6q-sabresd-hdcp-20140609091727.dtb
lrwxrwxrwx 1 root root        55 Jun  9 10:16 uImage-imx6q-sabresd-ldo.dtb -> uImage--3.10.17-r0-imx6q-sabresd-ldo-20140609091727.dtb
lrwxrwxrwx 1 root root        51 Jun  9 10:16 uImage-imx6q-sabresd.dtb -> uImage--3.10.17-r0-imx6q-sabresd-20140609091727.dtb
lrwxrwxrwx 1 root root        50 Jun  9 10:16 uImage-imx6qsabresd.bin -> uImage--3.10.17-r0-imx6qsabresd-20140609091727.bin
root@041dc56cadf6:/shared/build-imx6qsabresd#
```

### Start the build (fsl-image-machine-test)

    bitbake -k fsl-image-machine-test
    
Sample output:
```
root@79246811be09:/shared/build-imx6qsabresd# bitbake -k fsl-image-machine-test
Loading cache: 100% |##############################################################| ETA:  00:00:00
Loaded 1820 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies
NOTE: multiple providers are available for jpeg (jpeg, libjpeg-turbo)
NOTE: consider defining a PREFERRED_PROVIDER entry to match jpeg
NOTE: multiple providers are available for jpeg-native (jpeg-native, libjpeg-turbo-native)
NOTE: consider defining a PREFERRED_PROVIDER entry to match jpeg-native

Build Configuration:
BB_VERSION        = "1.22.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "arm-poky-linux-gnueabi"
MACHINE           = "imx6qsabresd"
DISTRO            = "poky"
DISTRO_VERSION    = "1.6.1"
TUNE_FEATURES     = "armv7a vfp neon callconvention-hard cortexa9"
TARGET_FPU        = "vfp-neon"
meta
meta-yocto        = "(nobranch):a43dba8c2904f9c1ce0425c53c5a7f4718121e6b"
meta-oe           = "(nobranch):dca466c074c9a35bc0133e7e0d65cca0731e2acf"
meta-fsl-arm      = "(nobranch):f5bf277a5a5fba2c3b64ed7d2dbec1903d96386b"
meta-fsl-arm-extra = "(nobranch):029f535cfbc5746288c6129babb2d7679927a183"
meta-fsl-demos    = "(nobranch):27fdb2f2642ecd55d5633bde880dd4c37acd0d42"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
WARNING: Failed to fetch URL http://www.latencytop.org/download/latencytop-0.5.tar.gz, attempting M
IRRORS if available
WARNING: gtk-immodule-am-et-2.24.22 was registered as shlib provider for im-am-et.so, changing it t
o gtk3-immodule-am-et-3.10.7 because it was built later
WARNING: gtk-immodule-cedilla-2.24.22 was registered as shlib provider for im-cedilla.so, changing
it to gtk3-immodule-cedilla-3.10.7 because it was built later
WARNING: gtk-immodule-cyrillic-translit-2.24.22 was registered as shlib provider for im-cyrillic-tr
anslit.so, changing it to gtk3-immodule-cyrillic-translit-3.10.7 because it was built later
WARNING: gtk-immodule-inuktitut-2.24.22 was registered as shlib provider for im-inuktitut.so, chang
ing it to gtk3-immodule-inuktitut-3.10.7 because it was built later
WARNING: gtk-immodule-ipa-2.24.22 was registered as shlib provider for im-ipa.so, changing it to gt
k3-immodule-ipa-3.10.7 because it was built later
WARNING: gtk-immodule-multipress-2.24.22 was registered as shlib provider for im-multipress.so, cha
nging it to gtk3-immodule-multipress-3.10.7 because it was built later
WARNING: gtk-immodule-thai-2.24.22 was registered as shlib provider for im-thai.so, changing it to
gtk3-immodule-thai-3.10.7 because it was built later
WARNING: gtk-immodule-ti-er-2.24.22 was registered as shlib provider for im-ti-er.so, changing it t
o gtk3-immodule-ti-er-3.10.7 because it was built later
WARNING: gtk-immodule-ti-et-2.24.22 was registered as shlib provider for im-ti-et.so, changing it t
o gtk3-immodule-ti-et-3.10.7 because it was built later
WARNING: gtk-immodule-viqr-2.24.22 was registered as shlib provider for im-viqr.so, changing it to
gtk3-immodule-viqr-3.10.7 because it was built later
WARNING: gtk-immodule-xim-2.24.22 was registered as shlib provider for im-xim.so, changing it to gt
k3-immodule-xim-3.10.7 because it was built later
WARNING: gtk-printbackend-file-2.24.22 was registered as shlib provider for libprintbackend-file.so
, changing it to gtk3-printbackend-file-3.10.7 because it was built later
WARNING: gtk-printbackend-lpr-2.24.22 was registered as shlib provider for libprintbackend-lpr.so,
changing it to gtk3-printbackend-lpr-3.10.7 because it was built later
WARNING: nbench-byte: No generic license file exists for: freely in any provider
WARNING: nbench-byte: No generic license file exists for: distributable in any provider
NOTE: Tasks Summary: Attempted 5256 tasks of which 4274 didn't need to be rerun and all succeeded.

Summary: There were 16 WARNING messages shown.
root@79246811be09:/shared/build-imx6qsabresd#
```

If the build is successful, the following files will be created under `$TOPDIR/tmp/deploy/images/$MACHINE`
```
root@79246811be09:/shared/build-imx6qsabresd# ls -la tmp/deploy/images/imx6qsabresd/
total 3083844
drwxr-xr-x 2 root root      4096 Jun 16 07:22 .
drwxr-xr-x 3 root root      4096 Jun 16 03:08 ..
-rw-r--r-- 2 root root       294 Jun 16 07:16 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
-rw-r--r-- 1 root root 968884224 Jun 16 07:21 fsl-image-machine-test-imx6qsabresd-20140616063843.rootfs.ext3
-rw-r--r-- 1 root root     32851 Jun 16 07:20 fsl-image-machine-test-imx6qsabresd-20140616063843.rootfs.manifest
-rw-r--r-- 1 root root 985661440 Jun 16 07:22 fsl-image-machine-test-imx6qsabresd-20140616063843.rootfs.sdcard
-rw-r--r-- 1 root root 183076895 Jun 16 07:20 fsl-image-machine-test-imx6qsabresd-20140616063843.rootfs.tar.bz2
lrwxrwxrwx 1 root root        62 Jun 16 07:22 fsl-image-machine-test-imx6qsabresd.ext3 -> fsl-image-machine-test-imx6qsabresd-20140616063843.rootfs.ext3
lrwxrwxrwx 1 root root        66 Jun 16 07:22 fsl-image-machine-test-imx6qsabresd.manifest -> fsl-image-machine-test-imx6qsabresd-20140616063843.rootfs.manifest
lrwxrwxrwx 1 root root        64 Jun 16 07:22 fsl-image-machine-test-imx6qsabresd.sdcard -> fsl-image-machine-test-imx6qsabresd-20140616063843.rootfs.sdcard
lrwxrwxrwx 1 root root        65 Jun 16 07:22 fsl-image-machine-test-imx6qsabresd.tar.bz2 -> fsl-image-machine-test-imx6qsabresd-20140616063843.rootfs.tar.bz2
-rw-r--r-- 2 root root    597640 Jun 16 03:08 modules--3.10.17-r0-imx6qsabresd-20140616021020.tgz
lrwxrwxrwx 1 root root        51 Jun 16 03:08 modules-imx6qsabresd.tgz -> modules--3.10.17-r0-imx6qsabresd-20140616021020.tgz
-rwxr-xr-x 2 root root    314368 Jun 16 04:21 u-boot-imx6qsabresd-v2014.01-r0.imx
lrwxrwxrwx 1 root root        35 Jun 16 04:22 u-boot-imx6qsabresd.imx -> u-boot-imx6qsabresd-v2014.01-r0.imx
lrwxrwxrwx 1 root root        35 Jun 16 04:22 u-boot.imx -> u-boot-imx6qsabresd-v2014.01-r0.imx
lrwxrwxrwx 1 root root        50 Jun 16 03:08 uImage -> uImage--3.10.17-r0-imx6qsabresd-20140616021020.bin
-rw-r--r-- 2 root root     47179 Jun 16 03:08 uImage--3.10.17-r0-imx6q-sabresd-20140616021020.dtb
-rw-r--r-- 2 root root     47268 Jun 16 03:08 uImage--3.10.17-r0-imx6q-sabresd-hdcp-20140616021020.dtb
-rw-r--r-- 2 root root     47179 Jun 16 03:08 uImage--3.10.17-r0-imx6q-sabresd-ldo-20140616021020.dtb
-rw-r--r-- 2 root root   5264192 Jun 16 03:08 uImage--3.10.17-r0-imx6qsabresd-20140616021020.bin
lrwxrwxrwx 1 root root        56 Jun 16 03:08 uImage-imx6q-sabresd-hdcp.dtb -> uImage--3.10.17-r0-imx6q-sabresd-hdcp-20140616021020.dtb
lrwxrwxrwx 1 root root        55 Jun 16 03:08 uImage-imx6q-sabresd-ldo.dtb -> uImage--3.10.17-r0-imx6q-sabresd-ldo-20140616021020.dtb
lrwxrwxrwx 1 root root        51 Jun 16 03:08 uImage-imx6q-sabresd.dtb -> uImage--3.10.17-r0-imx6q-sabresd-20140616021020.dtb
lrwxrwxrwx 1 root root        50 Jun 16 03:08 uImage-imx6qsabresd.bin -> uImage--3.10.17-r0-imx6qsabresd-20140616021020.bin
root@79246811be09:/shared/build-imx6qsabresd#
```

Among all generated files, `fsl-image-machine-test-imxx6qsabresd.sdcard` is ready to be flashed onto a uSDHC.


### Start the build (fsl-image-multimedia-full)

    bitbake -k fsl-image-multimedia-full
    
Sample output:
```
root@79246811be09:/shared/build-imx6qsabresd# bitbake -k fsl-image-multimedia-full
Parsing recipes: 100% |###############################################################| Time: 00:00:36
Parsing of 1393 .bb files complete (0 cached, 1393 parsed). 1819 targets, 99 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies
NOTE: multiple providers are available for jpeg (jpeg, libjpeg-turbo)
NOTE: consider defining a PREFERRED_PROVIDER entry to match jpeg
NOTE: multiple providers are available for jpeg-native (jpeg-native, libjpeg-turbo-native)
NOTE: consider defining a PREFERRED_PROVIDER entry to match jpeg-native

Build Configuration:
BB_VERSION        = "1.22.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "arm-poky-linux-gnueabi"
MACHINE           = "imx6qsabresd"
DISTRO            = "poky"
DISTRO_VERSION    = "1.6.1"
TUNE_FEATURES     = "armv7a vfp neon callconvention-hard cortexa9"
TARGET_FPU        = "vfp-neon"
meta
meta-yocto        = "(nobranch):a43dba8c2904f9c1ce0425c53c5a7f4718121e6b"
meta-oe           = "(nobranch):dca466c074c9a35bc0133e7e0d65cca0731e2acf"
meta-fsl-arm      = "(nobranch):f5bf277a5a5fba2c3b64ed7d2dbec1903d96386b"
meta-fsl-arm-extra = "(nobranch):029f535cfbc5746288c6129babb2d7679927a183"
meta-fsl-demos    = "(nobranch):27fdb2f2642ecd55d5633bde880dd4c37acd0d42"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/b/base-passwd/base-passwd_3.5.29.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://downloads.sourceforge.net/project/libpng/libpng16/1.6.8/libpng-1.6.8.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.freedesktop.org/pub/mesa/9.2.5/MesaLib-9.2.5.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/apr/apr-1.4.8.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/apr/apr-util-1.5.2.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/subversion/subversion-1.7.10.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/dosfstools-2.11.src.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/d/dpkg/dpkg_1.17.4.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://ftp.de.debian.org/debian/pool/main/m/mklibs/mklibs_0.1.38.tar.gz, attempting MIRRORS if available
NOTE: Tasks Summary: Attempted 4275 tasks of which 30 didn't need to be rerun and all succeeded.

Summary: There were 9 WARNING messages shown.
root@79246811be09:/shared/build-imx6qsabresd#
```

If the build is successful, the following files will be created under `$TOPDIR/tmp/deploy/images/$MACHINE`
```
root@79246811be09:/shared/build-imx6qsabresd# ls -la tmp/deploy/images/imx6qsabresd/
total 1146332
drwxr-xr-x 2 root root      4096 Jun 16 04:32 .
drwxr-xr-x 3 root root      4096 Jun 16 03:08 ..
-rw-r--r-- 2 root root       294 Jun 16 04:26 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
-rw-r--r-- 1 root root 562036736 Jun 16 04:31 fsl-image-multimedia-full-imx6qsabresd-20140616021020.rootfs.ext3
-rw-r--r-- 1 root root     25581 Jun 16 04:30 fsl-image-multimedia-full-imx6qsabresd-20140616021020.rootfs.manifest
-rw-r--r-- 1 root root 578813952 Jun 16 04:32 fsl-image-multimedia-full-imx6qsabresd-20140616021020.rootfs.sdcard
-rw-r--r-- 1 root root 113132914 Jun 16 04:31 fsl-image-multimedia-full-imx6qsabresd-20140616021020.rootfs.tar.bz2
lrwxrwxrwx 1 root root        65 Jun 16 04:32 fsl-image-multimedia-full-imx6qsabresd.ext3 -> fsl-image-multimedia-full-imx6qsabresd-20140616021020.rootfs.ext3
lrwxrwxrwx 1 root root        69 Jun 16 04:32 fsl-image-multimedia-full-imx6qsabresd.manifest -> fsl-image-multimedia-full-imx6qsabresd-20140616021020.rootfs.manifest
lrwxrwxrwx 1 root root        67 Jun 16 04:32 fsl-image-multimedia-full-imx6qsabresd.sdcard -> fsl-image-multimedia-full-imx6qsabresd-20140616021020.rootfs.sdcard
lrwxrwxrwx 1 root root        68 Jun 16 04:32 fsl-image-multimedia-full-imx6qsabresd.tar.bz2 -> fsl-image-multimedia-full-imx6qsabresd-20140616021020.rootfs.tar.bz2
-rw-r--r-- 2 root root    597640 Jun 16 03:08 modules--3.10.17-r0-imx6qsabresd-20140616021020.tgz
lrwxrwxrwx 1 root root        51 Jun 16 03:08 modules-imx6qsabresd.tgz -> modules--3.10.17-r0-imx6qsabresd-20140616021020.tgz
-rwxr-xr-x 2 root root    314368 Jun 16 04:21 u-boot-imx6qsabresd-v2014.01-r0.imx
lrwxrwxrwx 1 root root        35 Jun 16 04:22 u-boot-imx6qsabresd.imx -> u-boot-imx6qsabresd-v2014.01-r0.imx
lrwxrwxrwx 1 root root        35 Jun 16 04:22 u-boot.imx -> u-boot-imx6qsabresd-v2014.01-r0.imx
lrwxrwxrwx 1 root root        50 Jun 16 03:08 uImage -> uImage--3.10.17-r0-imx6qsabresd-20140616021020.bin
-rw-r--r-- 2 root root     47179 Jun 16 03:08 uImage--3.10.17-r0-imx6q-sabresd-20140616021020.dtb
-rw-r--r-- 2 root root     47268 Jun 16 03:08 uImage--3.10.17-r0-imx6q-sabresd-hdcp-20140616021020.dtb
-rw-r--r-- 2 root root     47179 Jun 16 03:08 uImage--3.10.17-r0-imx6q-sabresd-ldo-20140616021020.dtb
-rw-r--r-- 2 root root   5264192 Jun 16 03:08 uImage--3.10.17-r0-imx6qsabresd-20140616021020.bin
lrwxrwxrwx 1 root root        56 Jun 16 03:08 uImage-imx6q-sabresd-hdcp.dtb -> uImage--3.10.17-r0-imx6q-sabresd-hdcp-20140616021020.dtb
lrwxrwxrwx 1 root root        55 Jun 16 03:08 uImage-imx6q-sabresd-ldo.dtb -> uImage--3.10.17-r0-imx6q-sabresd-ldo-20140616021020.dtb
lrwxrwxrwx 1 root root        51 Jun 16 03:08 uImage-imx6q-sabresd.dtb -> uImage--3.10.17-r0-imx6q-sabresd-20140616021020.dtb
lrwxrwxrwx 1 root root        50 Jun 16 03:08 uImage-imx6qsabresd.bin -> uImage--3.10.17-r0-imx6qsabresd-20140616021020.bin
root@79246811be09:/shared/build-imx6qsabresd#
```

Among all generated files, `fsl-image-multimedia-full-imx6qsabresd.sdcard` is ready to be flashed onto a uSDHC.


## Building the image for the Wandboard (i.MX6 DualLite)

Precondition: logged into the container.

Create an environment variable

    export YOCTO=/opt/yocto

Configure SHA for each layer

    #TODO: poky
    #TODO: meta-fsl
    
Create the build environment (notice the workaround to allow $TOPDIR outside $YOCTO)

    cd $YOCTO/fsl-community-bsp
    ln -sf ~/shared/build-wandboard-dual
    MACHINE=wandboard-dual \
        source ./setup-environment \
        build-wandboard-dual
        
Verify (and if necessary update) the build configuration under `conf/`

    #TODO
    
Workaround: allow bitbake to run as root

    touch conf/sanity.conf

Workaround: edit conf/bblayer.conf and replace BSPDIR definition with

    BSPDIR := "/opt/yocto/fsl-community-bsp"
    
### Start the build (core-image-sato)

    bitbake -k core-image-sato
    
Sample output:
```
root@041dc56cadf6:/shared/build-wandboard-dual# bitbake -k core-image-sato
Parsing recipes: 100% |######################################################################################################################| Time: 00:00:36
Parsing of 1393 .bb files complete (0 cached, 1393 parsed). 1819 targets, 95 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies
NOTE: multiple providers are available for jpeg (jpeg, libjpeg-turbo)
NOTE: consider defining a PREFERRED_PROVIDER entry to match jpeg
NOTE: multiple providers are available for jpeg-native (jpeg-native, libjpeg-turbo-native)
NOTE: consider defining a PREFERRED_PROVIDER entry to match jpeg-native

Build Configuration:
BB_VERSION        = "1.22.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "arm-poky-linux-gnueabi"
MACHINE           = "wandboard-dual"
DISTRO            = "poky"
DISTRO_VERSION    = "1.6"
TUNE_FEATURES     = "armv7a vfp neon callconvention-hard cortexa9"
TARGET_FPU        = "vfp-neon"
meta
meta-yocto        = "(nobranch):62b1fef7875a6f9c55344fa6bcc7d4b6672eac1f"
meta-oe           = "(nobranch):dca466c074c9a35bc0133e7e0d65cca0731e2acf"
meta-fsl-arm      = "(nobranch):f5bf277a5a5fba2c3b64ed7d2dbec1903d96386b"
meta-fsl-arm-extra = "(nobranch):48cba7af1b94a60fbcbf4ac7bdb0edb3f40b4ae5"
meta-fsl-demos    = "(nobranch):27fdb2f2642ecd55d5633bde880dd4c37acd0d42"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
WARNING: Checksum failure encountered with download of http://www.yoctoproject.org/downloads/pseudo/pseudo-1.5.1.tar.bz2 - will attempt other sources if available
WARNING: Renaming /opt/yocto/fsl-community-bsp/downloads/pseudo-1.5.1.tar.bz2 to /opt/yocto/fsl-community-bsp/downloads/pseudo-1.5.1.tar.bz2_bad-checksum_9eea4cce34081500a5ba3cbbffbe5d74
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/b/base-passwd/base-passwd_3.5.29.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://downloads.sourceforge.net/project/libpng/libpng16/1.6.8/libpng-1.6.8.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/apr/apr-1.4.8.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/apr/apr-util-1.5.2.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/subversion/subversion-1.7.10.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/dosfstools-2.11.src.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/d/dpkg/dpkg_1.17.4.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://ftp.de.debian.org/debian/pool/main/m/mklibs/mklibs_0.1.38.tar.gz, attempting MIRRORS if available
NOTE: Tasks Summary: Attempted 4734 tasks of which 29 didn't need to be rerun and all succeeded.

Summary: There were 10 WARNING messages shown.
root@041dc56cadf6:/shared/build-wandboard-dual#
```

If the build is successful, the following files will be created under `$TOPDIR/tmp/deploy/images/$MACHINE`
```
root@041dc56cadf6:/shared/build-wandboard-dual# ls -la tmp/deploy/images/wandboard-dual/
total 565640
drwxr-xr-x 2 root root      4096 Jun  9 00:29 .
drwxr-xr-x 3 root root      4096 Jun  8 23:09 ..
-rw-r--r-- 2 root root       294 Jun  9 00:26 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
-rw-r--r-- 1 root root 301989888 Jun  9 00:28 core-image-sato-wandboard-dual-20140608221501.rootfs.ext3
-rw-r--r-- 1 root root     18379 Jun  9 00:28 core-image-sato-wandboard-dual-20140608221501.rootfs.manifest
-rw-r--r-- 1 root root 318767104 Jun  9 00:29 core-image-sato-wandboard-dual-20140608221501.rootfs.sdcard
-rw-r--r-- 1 root root  64459533 Jun  9 00:28 core-image-sato-wandboard-dual-20140608221501.rootfs.tar.bz2
lrwxrwxrwx 1 root root        57 Jun  9 00:28 core-image-sato-wandboard-dual.ext3 -> core-image-sato-wandboard-dual-20140608221501.rootfs.ext3
lrwxrwxrwx 1 root root        61 Jun  9 00:28 core-image-sato-wandboard-dual.manifest -> core-image-sato-wandboard-dual-20140608221501.rootfs.manifest
lrwxrwxrwx 1 root root        59 Jun  9 00:29 core-image-sato-wandboard-dual.sdcard -> core-image-sato-wandboard-dual-20140608221501.rootfs.sdcard
lrwxrwxrwx 1 root root        60 Jun  9 00:28 core-image-sato-wandboard-dual.tar.bz2 -> core-image-sato-wandboard-dual-20140608221501.rootfs.tar.bz2
-rw-r--r-- 2 root root    628904 Jun  8 23:09 modules--3.10.17-r0-wandboard-dual-20140608221501.tgz
lrwxrwxrwx 1 root root        53 Jun  8 23:09 modules-wandboard-dual.tgz -> modules--3.10.17-r0-wandboard-dual-20140608221501.tgz
-rwxr-xr-x 2 root root    285696 Jun  9 00:23 u-boot-wandboard-dual-v2014.01-r0.imx
lrwxrwxrwx 1 root root        37 Jun  9 00:23 u-boot-wandboard-dual.imx -> u-boot-wandboard-dual-v2014.01-r0.imx
lrwxrwxrwx 1 root root        37 Jun  9 00:23 u-boot.imx -> u-boot-wandboard-dual-v2014.01-r0.imx
lrwxrwxrwx 1 root root        52 Jun  8 23:09 zImage -> zImage--3.10.17-r0-wandboard-dual-20140608221501.bin
-rw-r--r-- 2 root root     41322 Jun  8 23:09 zImage--3.10.17-r0-imx6dl-wandboard-20140608221501.dtb
-rw-r--r-- 2 root root   5301304 Jun  8 23:09 zImage--3.10.17-r0-wandboard-dual-20140608221501.bin
lrwxrwxrwx 1 root root        54 Jun  8 23:09 zImage-imx6dl-wandboard.dtb -> zImage--3.10.17-r0-imx6dl-wandboard-20140608221501.dtb
lrwxrwxrwx 1 root root        52 Jun  8 23:09 zImage-wandboard-dual.bin -> zImage--3.10.17-r0-wandboard-dual-20140608221501.bin
root@041dc56cadf6:/shared/build-wandboard-dual#
```

Among all generated files, `core-image-sato-wandboard-dual.sdcard` is ready to be flashed onto a uSDHC.


### Start the build (core-image-full-cmdline)

    bitbake -k core-image-full-cmdline
    
Sample output:
```
root@363e79a5f3bd:/shared/build-wandboard-dual# bitbake -k core-image-full-cmdline
Loading cache: 100% |#################################################################| ETA:  00:00:00
Loaded 1820 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        = "1.22.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "arm-poky-linux-gnueabi"
MACHINE           = "wandboard-dual"
DISTRO            = "poky"
DISTRO_VERSION    = "1.6.1"
TUNE_FEATURES     = "armv7a vfp neon callconvention-hard cortexa9"
TARGET_FPU        = "vfp-neon"
meta
meta-yocto        = "(nobranch):a43dba8c2904f9c1ce0425c53c5a7f4718121e6b"
meta-oe           = "(nobranch):dca466c074c9a35bc0133e7e0d65cca0731e2acf"
meta-fsl-arm      = "(nobranch):f5bf277a5a5fba2c3b64ed7d2dbec1903d96386b"
meta-fsl-arm-extra = "(nobranch):029f535cfbc5746288c6129babb2d7679927a183"
meta-fsl-demos    = "(nobranch):27fdb2f2642ecd55d5633bde880dd4c37acd0d42"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
WARNING: Failed to fetch URL ftp://ftp.suse.com/pub/people/kukuk/pax/pax-3.4.tar.bz2, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/n/net-tools/net-tools_1.60-25.diff.gz;apply=no;name=patch, attempting MIRRORS if available
NOTE: Tasks Summary: Attempted 2561 tasks of which 25 didn't need to be rerun and all succeeded.

Summary: There were 2 WARNING messages shown.
root@363e79a5f3bd:/shared/build-wandboard-dual#
```

If the build is successful, the following files will be created under `$TOPDIR/tmp/deploy/images/$MACHINE`
```
root@363e79a5f3bd:/shared/build-wandboard-dual# ls -la tmp/deploy/images/wandboard-dual/
total 308724
drwxr-xr-x 2 root root      4096 Jun 14 15:15 .
drwxr-xr-x 3 root root      4096 Jun 14 14:28 ..
-rw-r--r-- 2 root root       294 Jun 14 15:13 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
-rw-r--r-- 1 root root 150994944 Jun 14 15:15 core-image-full-cmdline-wandboard-dual-20140614133742.rootfs.ext3
-rw-r--r-- 1 root root      7752 Jun 14 15:15 core-image-full-cmdline-wandboard-dual-20140614133742.rootfs.manifest
-rw-r--r-- 1 root root 167772160 Jun 14 15:15 core-image-full-cmdline-wandboard-dual-20140614133742.rootfs.sdcard
-rw-r--r-- 1 root root  36353447 Jun 14 15:15 core-image-full-cmdline-wandboard-dual-20140614133742.rootfs.tar.bz2
lrwxrwxrwx 1 root root        65 Jun 14 15:15 core-image-full-cmdline-wandboard-dual.ext3 -> core-image-full-cmdline-wandboard-dual-20140614133742.rootfs.ext3
lrwxrwxrwx 1 root root        69 Jun 14 15:15 core-image-full-cmdline-wandboard-dual.manifest -> core-image-full-cmdline-wandboard-dual-20140614133742.rootfs.manifest
lrwxrwxrwx 1 root root        67 Jun 14 15:15 core-image-full-cmdline-wandboard-dual.sdcard -> core-image-full-cmdline-wandboard-dual-20140614133742.rootfs.sdcard
lrwxrwxrwx 1 root root        68 Jun 14 15:15 core-image-full-cmdline-wandboard-dual.tar.bz2 -> core-image-full-cmdline-wandboard-dual-20140614133742.rootfs.tar.bz2
-rw-r--r-- 2 root root    628903 Jun 14 14:28 modules--3.10.17-r0-wandboard-dual-20140614133742.tgz
lrwxrwxrwx 1 root root        53 Jun 14 14:28 modules-wandboard-dual.tgz -> modules--3.10.17-r0-wandboard-dual-20140614133742.tgz
-rwxr-xr-x 2 root root    285696 Jun 14 15:11 u-boot-wandboard-dual-v2014.01-r0.imx
lrwxrwxrwx 1 root root        37 Jun 14 15:11 u-boot-wandboard-dual.imx -> u-boot-wandboard-dual-v2014.01-r0.imx
lrwxrwxrwx 1 root root        37 Jun 14 15:11 u-boot.imx -> u-boot-wandboard-dual-v2014.01-r0.imx
lrwxrwxrwx 1 root root        52 Jun 14 14:28 zImage -> zImage--3.10.17-r0-wandboard-dual-20140614133742.bin
-rw-r--r-- 2 root root     41322 Jun 14 14:28 zImage--3.10.17-r0-imx6dl-wandboard-20140614133742.dtb
-rw-r--r-- 2 root root   5301312 Jun 14 14:28 zImage--3.10.17-r0-wandboard-dual-20140614133742.bin
lrwxrwxrwx 1 root root        54 Jun 14 14:28 zImage-imx6dl-wandboard.dtb -> zImage--3.10.17-r0-imx6dl-wandboard-20140614133742.dtb
lrwxrwxrwx 1 root root        52 Jun 14 14:28 zImage-wandboard-dual.bin -> zImage--3.10.17-r0-wandboard-dual-20140614133742.bin
root@363e79a5f3bd:/shared/build-wandboard-dual#
```

Among all generated files, `core-image-full-cmdline-wandboard-dual.sdcard` is ready to be flashed onto a uSDHC.


## Mirroring the generated images

This project includes a `do_mirror.sh` script to make it easy to mirror the files (image, packages, etc.) generated after a build to a local machine - for instance, for writing the image to a SD card, etc.

Before running the script you may need to configure the parameters at the beginning of the script; edit the file and read the comments for details:

    vi do_mirror.sh

Then invoke the script from the command line:

    ./do_mirror.sh


## Flashing wandboard image

### From Linux

Plug the uSDHC inside the host, use `dmesg` to verify the name of the device (example: `/dev/sdX`).
Write the image with the following command (replace `/dev/sdX` appropriately):

    sudo dd if=core-image-sato-wandboard-dual.sdcard of=/dev/sdX

### From MS Windows
From MS Windows, you may use [Win32 Disk Imager](http://sourceforge.net/projects/win32diskimager/) to burn a uSDHC
with the contents of `core-image-sato-wandboard-dual.sdcard`.

## Sample boot log

```
gmacario@ITM-GMACARIO-W7 ~
$ ssh root@192.168.64.107
root@wandboard-dual:~# uname -a
Linux wandboard-dual 3.10.17-1.0.0-wandboard+g9d567e4 #1 SMP PREEMPT Sun Jun 1 21:42:03 UTC 2014 armv7l GNU/Linux
root@wandboard-dual:~# df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root               278.9M    180.7M     83.8M  68% /
devtmpfs                372.8M      4.0K    372.8M   0% /dev
tmpfs                    40.0K         0     40.0K   0% /mnt/.psplash
tmpfs                   500.9M    192.0K    500.7M   0% /run
tmpfs                   500.9M     84.0K    500.8M   0% /var/volatile
/dev/mmcblk0p1            8.0M      5.1M      2.9M  64% /media/mmcblk0p1
root@wandboard-dual:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:1F:7B:B2:05:02
          inet addr:192.168.64.107  Bcast:192.168.64.255  Mask:255.255.255.0
          inet6 addr: fe80::21f:7bff:feb2:502/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:193 errors:0 dropped:0 overruns:0 frame:0
          TX packets:217 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:24691 (24.1 KiB)  TX bytes:28336 (27.6 KiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root@wandboard-dual:~# ls -la /media/mmcblk0p1/
drwxrwx---    2 root     disk         16384 Jan  1  1970 .
drwxr-xr-x    3 root     root          1024 Jan  1  1970 ..
-rwxrwx---    1 root     disk         41322 Jun  2 08:19 imx6dl-wandboard.dtb
-rwxrwx---    1 root     disk       5301312 Jun  2 08:19 zImage
root@wandboard-dual:~# cat /proc/cmdline
console=ttymxc0,115200 root=/dev/mmcblk0p2 rootwait rw
root@wandboard-dual:~#
```
