build-yocto
===========

[![](https://badge.imagelayers.io/gmacario/build-yocto:latest.svg)](https://imagelayers.io/?images=gmacario/build-yocto:latest 'Get your own badge on imagelayers.io')

This subproject of [easy-build](https://github.com/gmacario/easy-build) provides a quick and easy way
for creating embedded Linux distributions using the [Yocto Project](https://www.yoctoproject.org/) tools.

Building the Docker image
-------------------------

    $ cd .../easy-build
    $ docker build -t gmacario/build-yocto build-yocto/

Running the Docker image
------------------------

Type the following command to instantiate a clean development environment for the Yocto Project:

    $ docker run -ti gmacario/build-yocto

Optionally, you may use the `--volume=[host-src:]container-dest` option to share a directory between the host and the container, as in the following example

    $ docker run -ti --volume=${PWD}/shared:/home/build/shared gmacario/build-yocto

Please refer to https://docs.docker.com/engine/reference/run/#volume-shared-filesystems for details

Congratulations! You can now execute the Yocto Project tools to create your own embedded Linux distribution.

Using Yocto
-----------

This section shows a few commands to make sure that the Yocto build environment is properly installed.
Please refer to the [Yocto Project documentation](https://www.yoctoproject.org/documentation) for details.

### Clone the Yocto metadata

Clone the poky repository (in our example, Yocto Project 2.0 - a.k.a. "jethro")

    $ mkdir -p ~/shared && sudo chown build.build ~/shared
    $ cd ~/shared
    $ git clone -b jethro git://git.yoctoproject.org/poky
    
### Update the Yocto metadata

Fetch the latest updates of the poky repository

    $ cd ~/shared/poky && git pull --all --prune

### Create the build environment

    $ cd ~/shared
    $ source ~/shared/poky/oe-init-build-env ~/shared/build-test01

You may inspect and - if necessary - change the configuration files under `conf/`.

### Build the minimal Yocto image

<!-- (2016-02-22 15:00 CET) -->

After sourcing `oe-init-build-env` you are ready to start the build

    $ bitbake -k core-image-minimal
    
Result

```
TODO
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
