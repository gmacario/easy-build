# build-yocto-genivi

build-yocto-genivi is a subproject of [easy-build](https://github.com/gmacario/easy-build) and has the objective of providing a simplified environment where to rebuild from sources the [GENIVI Yocto Baseline](http://projects.genivi.org/GENIVI_Baselines/meta-ivi/home), as well as running it on virtual targets such as QEMU, VirtualBox or VMware.

build-yocto-genivi relies on [Docker](http://www.docker.com/) and creates a clean, stand-alone development environment complete with all the tools needed to perform a full build of the target image.

## Getting the Docker image locally

Several options are possible here.

### Pulling Docker image from index.docker.io and running it

The most recent builds of the build-yocto-genivi project are published on [Docker Hub](https://hub.docker.com/):

    docker pull gmacario/build-yocto-genivi

### Using the build.sh script

Alternatively you may do a local rebuild of your Docker image following to the instructions inside the `Dockerfile`.
You may do so through the following command

    ./build.sh
    
### Creating Docker image from Dockerfile and running it

This is basically what the `build.sh` script does, but you may customize the Docker image or add other configuration options (please consult `man docker` for details)

    docker build -t my-build-yocto-genivi .

## Running the Docker inside a container

Prerequisite: the Docker image is already available locally.

As before, several options are possible.

### Using the run.sh script (quick)

This command will execute faster in case the container has already run previously.

    ./run.sh

### Running docker manually

This command will create and start a new container

    docker run -t -i gmacario/build-yocto-genivi

## Using build-yocto-genivi

Adapted from [meta-ivi README.md](http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md)

Prerequisite: the container is already running.

### Preparation

    # Make sure that /dev/shm is writable (TODO: why???)
    chmod a+w /dev/shm
    
    # Make sure that ~build/shared directory is owned by user "build"
    chown build.build ~build/shared
    
    # Switch to user 'build'
    su - build

### Initialize build environment

After logging in as user "build" execute the following commands:

    export GENIVI=~/genivi-baseline
    source $GENIVI/poky/oe-init-build-env ~/shared/my-genivi-build
    export TOPDIR=$PWD

### Building the GENIVI image

#### Configure build

The following commands must be executed only once:

See `configure_build.sh` for details

    cd $TOPDIR
    curl \
	https://raw.githubusercontent.com/gmacario/easy-build/master/build-yocto-genivi/configure_build.sh \
	>configure_build.sh

Review `configure_build.sh` and make any modifications if needed, then invoke the script

    sh configure_build.sh

For help about syntax of `conf/bblayers.conf` and `conf/local.conf` please refer to the
[Yocto Project Documentation](http://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html).

#### Perform build

    cd $TOPDIR
    bitbake -k intrepid-image

**NOTE**: This command may take a few hours to complete.

Sample output:
```
build@0e1cc1d41562:~/shared/my-genivi-build$ bitbake -k intrepid-image
Parsing recipes: 100% |###############################################################| Time: 00:00:23
Parsing of 907 .bb files complete (0 cached, 907 parsed). 1275 targets, 150 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        = "1.23.1"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "i586-poky-linux"
MACHINE           = "qemux86"
DISTRO            = "poky-ivi-systemd"
DISTRO_VERSION    = "7.0.0"
TUNE_FEATURES     = "m32 i586"
TARGET_FPU        = ""
meta
meta-yocto
meta-yocto-bsp    = "(detachedfromf3d0846):f3d08464ef0e8ee11fe9d59857f4be314cd64580"
meta-ivi
meta-ivi-bsp      = "(detachedfrom7.0.0):d294f2137347caf5721c3af0e53e4de750574be9"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/b/base-passwd/base-passwd_3.5.29.tar.gz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://downloads.sourceforge.net/project/libpng/libpng16/1.6.10/libpng-1.6.10.tar.xz, attempting MIRRORS if available
NOTE: validating kernel config, see log.do_kernel_configcheck for details
WARNING: QA Issue: ELF binary '/home/build/shared/my-genivi-build/tmp/work/i586-poky-linux/systemd/1_213+gitAUTOINC+c9679c652b-r0/packages-split/systemd/lib/systemd/systemd' has relocations in .text
WARNING: QA Issue: ELF binary '/home/build/shared/my-genivi-build/tmp/work/i586-poky-linux/systemd/1_213+gitAUTOINC+c9679c652b-r0/packages-split/systemd/lib/systemd/systemd-machined' has relocations in .text
WARNING: QA Issue: ELF binary '/home/build/shared/my-genivi-build/tmp/work/i586-poky-linux/systemd/1_213+gitAUTOINC+c9679c652b-r0/packages-split/systemd/lib/systemd/systemd-shutdown' has relocations in .text
WARNING: QA Issue: ELF binary '/home/build/shared/my-genivi-build/tmp/work/i586-poky-linux/systemd/1_213+gitAUTOINC+c9679c652b-r0/packages-split/systemd/lib/systemd/system-generators/systemd-fstab-generator' has relocations in .text
WARNING: QA Issue: ELF binary '/home/build/shared/my-genivi-build/tmp/work/i586-poky-linux/systemd/1_213+gitAUTOINC+c9679c652b-r0/packages-split/systemd/bin/systemctl' has relocations in .text
WARNING: Failed to fetch URL http://0pointer.de/lennart/projects/libdaemon/libdaemon-0.14.tar.gz, attempting MIRRORS if available
WARNING: QA Issue: bluez5: configure was passed unrecognised options: --with-systemdunitdir
WARNING: Failed to fetch URL http://www.apache.org/dist/subversion/subversion-1.7.10.tar.bz2, attempting MIRRORS if availableWARNING: QA Issue: coreutils: configure was passed unrecognised options: --disable-acl
WARNING: Failed to fetch URL http://0pointer.de/lennart/projects/nss-mdns/nss-mdns-0.10.tar.gz, attempting MIRRORS if available
WARNING: QA Issue: fuse: configure was passed unrecognised options: --disable-kernel-module
WARNING: QA Issue: ELF binary '/home/build/shared/my-genivi-build/tmp/work/i586-poky-linux/wayland-ivi-extension/1.2.0-rc7+gitAUTOINC+6ee4b2e418-rc7/packages-split/wayland-ivi-extension/usr/lib/libilmClient.so.1.2.0' has relocations in .text
WARNING: QA Issue: ELF binary '/home/build/shared/my-genivi-build/tmp/work/i586-poky-linux/wayland-ivi-extension/1.2.0-rc7+gitAUTOINC+6ee4b2e418-rc7/packages-split/wayland-ivi-extension/usr/lib/libilmControl.so.1.2.0' has relocations in .text
WARNING: QA Issue: ELF binary '/home/build/shared/my-genivi-build/tmp/work/i586-poky-linux/wayland-ivi-extension/1.2.0-rc7+gitAUTOINC+6ee4b2e418-rc7/packages-split/wayland-ivi-extension/usr/lib/weston/ivi-controller.so' has relocations in .text
WARNING: Failed to fetch URL ftp://ftp.debian.org/debian/pool/main/d/dpkg/dpkg_1.17.4.tar.xz, attempting MIRRORS if available
WARNING: Failed to fetch URL http://ftp.de.debian.org/debian/pool/main/m/mklibs/mklibs_0.1.39.tar.xz, attempting MIRRORS if available
WARNING: libitzam: No generic license file exists for: Simplified in any provider
NOTE: Tasks Summary: Attempted 2975 tasks of which 28 didn't need to be rerun and all succeeded.

Summary: There were 19 WARNING messages shown.
build@0e1cc1d41562:~/shared/my-genivi-build$
```

As a result of the build the following files will be created:
```
build@0e1cc1d41562:~/shared/my-genivi-build$ ls -la tmp/deploy/images/qemux86/
total 262744
drwxrwxr-x 2 build build      4096 Sep 17 07:57 .
drwxrwxr-x 3 build build      4096 Sep 17 07:43 ..
-rw-r--r-- 2 build build       294 Sep 17 07:54 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
lrwxrwxrwx 1 build build        73 Sep 17 07:43 bzImage -> bzImage--3.10.43+git0+199943142f_aa677a2d02-r0-qemux86-20140917063053.bin
-rw-r--r-- 2 build build   6557440 Sep 17 07:43 bzImage--3.10.43+git0+199943142f_aa677a2d02-r0-qemux86-20140917063053.bin
lrwxrwxrwx 1 build build        73 Sep 17 07:43 bzImage-qemux86.bin -> bzImage--3.10.43+git0+199943142f_aa677a2d02-r0-qemux86-20140917063053.bin
-rw-r--r-- 1 build build 239745024 Sep 17 07:57 intrepid-image-qemux86-20140917063053.rootfs.ext3
-rw-r--r-- 1 build build     31329 Sep 17 07:57 intrepid-image-qemux86-20140917063053.rootfs.manifest
-rw-r--r-- 1 build build  44663020 Sep 17 07:57 intrepid-image-qemux86-20140917063053.rootfs.tar.bz2
lrwxrwxrwx 1 build build        49 Sep 17 07:57 intrepid-image-qemux86.ext3 -> intrepid-image-qemux86-20140917063053.rootfs.ext3
lrwxrwxrwx 1 build build        53 Sep 17 07:57 intrepid-image-qemux86.manifest -> intrepid-image-qemux86-20140917063053.rootfs.manifest
lrwxrwxrwx 1 build build        52 Sep 17 07:57 intrepid-image-qemux86.tar.bz2 -> intrepid-image-qemux86-20140917063053.rootfs.tar.bz2
-rw-rw-r-- 2 build build  67728425 Sep 17 07:43 modules--3.10.43+git0+199943142f_aa677a2d02-r0-qemux86-20140917063053.tgz
lrwxrwxrwx 1 build build        73 Sep 17 07:43 modules-qemux86.tgz -> modules--3.10.43+git0+199943142f_aa677a2d02-r0-qemux86-20140917063053.tgz
build@0e1cc1d41562:~/shared/my-genivi-build$
```

In case the build fails, you may try to clean the offending tasks, as in the following example:

    bitbake -c cleansstate cairo
    
then invoke `bitbake intrepid-image` again.

### Running the created images with QEMU inside the container

FIXME: The commands in this section still do not work inside the container.

#### For QEMU vexpressa9

    $GENIVI/meta-ivi/scripts/runqemu horizon-image vexpressa9

#### For QEMU x86

    $GENIVI/poky/scripts/runqemu horizon-image qemux86

#### For QEMU x86-64

    $GENIVI/poky/scripts/runqemu horizon-image qemux86-x64
    
## (Optional) Committing the image after building the Yocto GENIVI Baseline

If the previous commands were successful, exit the container, then execute the following commands to persist the container into a Docker image:

    CONTAINER_ID=$(docker ps -lq)
    docker commit -m "John Doe <john.doe@me.com>" $CONTAINER_ID <repository:tag>

You may optionally push the image to a public Docker repository, like

    docker push <repository>

## Creating standalone images for execution under QEMU, VirtualBox and VMware Player

This works only for `MACHINE=qemux86`

Review the `create_standalone_images.sh` script to adjust the configurable parameters, then run

    ./create_standalone_images.sh

Follow the instructions displayed by the script for loading and running the images under:

* [qemu-system-i386](http://www.qemu.org/) (tested with qemu-kvm 1.0 on Ubuntu 12.04.4 LTS)
* [Oracle VM VirtualBox](https://www.virtualbox.org/) (tested with VirtualBox 4.3.10 on MS Windows 7 and Ubuntu 12.04.4 LTS)
* [VMware Player](http://www.vmware.com/products/player) (tested with VMware Player 6.0.1 on MS Windows 7)
