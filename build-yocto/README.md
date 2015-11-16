build-yocto
===========

[![](https://badge.imagelayers.io/gmacario/build-yocto:latest.svg)](https://imagelayers.io/?images=gmacario/build-yocto:latest 'Get your own badge on imagelayers.io')

This subproject of [easy-build](https://github.com/gmacario/easy-build) provides a quick and easy way
for creating embedded Linux distributions using the [Yocto Project](https://www.yoctoproject.org/) tools.

Building the Docker image
-------------------------

    $ docker build -t gmacario/build-yocto .

Running the Docker image
------------------------

You may use the `run.sh` script:

    $ cd .../build-yocto
    $ ./run.sh

Congratulations! You can now execute the Yocto Project tools to create your own embedded Linux distribution.

Using Yocto
-----------

This section shows a few commands to make sure that the Yocto build environment is properly installed.
Please refer to the [Yocto Project documentation](https://www.yoctoproject.org/documentation) for details.

### Select the Yocto release

Fetch the latest updates of the poky repository, then switch to the desired release
(in our example, Yocto Project 1.7 - a.k.a. "dizzy")

    $ cd /opt/yocto/poky
    $ git checkout dizzy

### Create the build environment

    $ cd /shared
    $ source /opt/yocto/poky/oe-init-build-env build-test01

You may inspect and - if necessary - change the configuration files under `conf/`.

### Start the build

    $ bitbake -k core-image-sato
    
Result

```
vagrant@e117d5aaa4f3:/shared/build-test02$ bitbake -k core-image-sato
Parsing recipes: 100% |###########################################################################| Time: 00:00:24
Parsing of 892 .bb files complete (0 cached, 892 parsed). 1289 targets, 40 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        = "1.25.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "i586-poky-linux"
MACHINE           = "qemux86"
DISTRO            = "poky"
DISTRO_VERSION    = "1.7"
TUNE_FEATURES     = "m32 i586"
TARGET_FPU        = ""
meta
meta-yocto
meta-yocto-bsp    = "master:ec6377bcf52d105cd23ac6bbbeddd38fee9337e4"

NOTE: Preparing RunQueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/b/base-passwd/base-passwd_3.5.29.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://downloads.sourceforge.net/project/libpng/libpng16/1.6.13/libpng-1.6.13.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://www.apache.org/dist/apr/apr-util-1.5.3.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://0pointer.de/lennart/projects/libdaemon/libdaemon-0.14.tar.gz, attempting MIRRORS if available
WARNING: Missing md5 SRC_URI checksum for /shared/build-test02/downloads/serf-1.3.8.tar.bz2, consider adding to the recipe:
SRC_URI[md5sum] = "2e4efe57ff28cb3202a112e90f0c2889"
WARNING: Failed to fetch URL http://0pointer.de/lennart/projects/nss-mdns/nss-mdns-0.10.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/d/dpkg/dpkg_1.17.4.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://ftp.de.debian.org/debian/pool/main/m/mklibs/mklibs_0.1.39.tar.xz, attempting MIRRORS if available
NOTE: validating kernel config, see log.do_kernel_configcheck for details
NOTE: Tasks Summary: Attempted 5154 tasks of which 16 didn't need to be rerun and all succeeded.

Summary: There were 8 WARNING messages shown.
vagrant@e117d5aaa4f3:/shared/build-test02$
```

### Using the "wic" tool

Starting from release 1.5, Yocto features the `wic` tool to build system images.

#### Show program version

    $ wic --version

Yocto 1.6 provides version 0.1.0

```
root@eb4b9143265d:/work/build-test01# wic --version
wic version 0.1.0
root@eb4b9143265d:/work/build-test01#
```

#### Show program help

    $ wic --help

Result:

```
root@eb4b9143265d:/work/build-test01# wic --help
Usage:

 Create a customized OpenEmbedded image

 usage: wic [--version] [--help] COMMAND [ARGS]

 Current 'wic' commands are:
    create            Create a new OpenEmbedded image
    list              List available values for options and image properties

 See 'wic help COMMAND' for more information on a specific command.


Options:
  --version   show program's version number and exit
  -h, --help  show this help message and exit
root@eb4b9143265d:/work/build-test01#
```

#### List available OpenEmbedded image properties

    $ wic list images

Result:

```
root@eb4b9143265d:/work/build-test01# wic list images
  directdisk            Create a 'pcbios' direct disk image
  mkefidisk             Create an EFI disk image
root@eb4b9143265d:/work/build-test01#
```

#### Getting help on "wic create"

    $ wic help create

Result:

```
NAME
    wic create - Create a new OpenEmbedded image

SYNOPSIS
    wic create <wks file or image name> [-o <DIRNAME> | --outdir <DIRNAME>]
        [-i <JSON PROPERTY FILE> | --infile <JSON PROPERTY_FILE>]
        [-e | --image-name] [-r, --rootfs-dir] [-b, --bootimg-dir]
        [-k, --kernel-dir] [-n, --native-sysroot] [-s, --skip-build-check]

DESCRIPTION
    This command creates an OpenEmbedded image based on the 'OE
    kickstart commands' found in the <wks file>.

    In order to do this, wic needs to know the locations of the
    various build artifacts required to build the image.

    Users can explicitly specify the build artifact locations using
    the -r, -b, -k, and -n options.  See below for details on where
    the corresponding artifacts are typically found in a normal
    OpenEmbedded build.

    Alternatively, users can use the -e option to have 'mic' determine
    those locations for a given image.  If the -e option is used, the
    user needs to have set the appropriate MACHINE variable in
    local.conf, and have sourced the build environment.

    The -e option is used to specify the name of the image to use the
    artifacts from e.g. core-image-sato.

    The -r option is used to specify the path to the /rootfs dir to
    use as the .wks rootfs source.

    The -b option is used to specify the path to the dir containing
    the boot artifacts (e.g. /EFI or /syslinux dirs) to use as the
    .wks bootimg source.

    The -k option is used to specify the path to the dir containing
    the kernel to use in the .wks bootimg.

    The -n option is used to specify the path to the native sysroot
    containing the tools to use to build the image.

    The -s option is used to skip the build check.  The build check is
    a simple sanity check used to determine whether the user has
    sourced the build environment so that the -e option can operate
    correctly.  If the user has specified the build artifact locations
    explicitly, 'wic' assumes the user knows what he or she is doing
    and skips the build check.

    When 'wic -e' is used, the locations for the build artifacts
    values are determined by 'wic -e' from the output of the 'bitbake
    -e' command given an image name e.g. 'core-image-minimal' and a
    given machine set in local.conf.  In that case, the image is
    created as if the following 'bitbake -e' variables were used:

    -r:        IMAGE_ROOTFS
    -k:        STAGING_KERNEL_DIR
    -n:        STAGING_DIR_NATIVE
    -b:        HDDDIR and STAGING_DATA_DIR (handlers decide which to use)

    If 'wic -e' is not used, the user needs to select the appropriate
    value for -b (as well as -r, -k, and -n).

    The -o option can be used to place the image in a directory with a
    different name and location.

    As an alternative to the wks file, the image-specific properties
    that define the values that will be used to generate a particular
    image can be specified on the command-line using the -i option and
    supplying a JSON object consisting of the set of name:value pairs
    needed by image creation.

    The set of properties available for a given image type can be
    listed using the 'wic list' command.
```

#### Create image

TODO

```
wic create directdisk -e core-image-minimal
```

Known issues and workarounds
----------------------------

### bitbake complains if run as root

```
root@eb4b9143265d:/work/build-test01# bitbake -k core-image-sato
ERROR:  OE-core's config sanity checker detected a potential misconfiguration.
    Either fix the cause of this error or at your own risk disable the checker (see sanity.conf).
    Following is the list of potential problems / advisories:

    Do not use Bitbake as root.
ERROR: Execution of event handler 'check_sanity_eventhandler' failed
ERROR: Command execution failed: Exited with 1

Summary: There were 3 ERROR messages shown, returning a non-zero exit code.
root@eb4b9143265d:/work/build-test01#
```

Workaround:

    $ touch conf/sanity.conf

<!-- EOF -->
