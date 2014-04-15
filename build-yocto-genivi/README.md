## Getting the Docker image locally

Several options are possible here.

### Using the build.sh script (quick)

    ./build.sh
    
### Pulling Docker image from index.docker.io and running it

    docker pull gmacario/build-yocto-genivi

### Creating Docker image from Dockerfile and running it

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
    
    # Make sure that ~build/tmp directory is owned by user "build"
    chown build.build ~build/tmp
    
    # Switch to user 'build'
    su - build

### Initialize build environment

After logging in as user "build" execute the following commands:

    export GENIVI=~/genivi-baseline
    source $GENIVI/poky/oe-init-build-env ~/tmp/my-genivi-build
    export TOPDIR=$PWD

### Building the GENIVI image

#### Configure build

The following commands must be executed only once:

See `configure_build.sh` for details

    cd $TOPDIR
    curl \
	https://raw.githubusercontent.com/gmacario/easy-build/master/build-yocto-genivi/configure_build.sh \
	>configure_build.sh

    # Review script and make any modifications if needed
    vi configure_build.sh

    # invoke the script
    sh configure_build.sh

For help about syntax of `conf/bblayers.conf` and `conf/local.conf` please refer to the [Yocto Project Documentation](http://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html).

#### Perform build

    cd $TOPDIR
    bitbake -k horizon-image

**NOTE**: This command may take a few hours to complete.

If the build is successful, the following files should be created under $TOPDIR/tmp/deploy:

    build@f502df276335:~/tmp/build-horizon-6.0.0-qemux86$ ls -la tmp/deploy/images/qemux86/
    total 276456
    drwxrwxr-x 2 build build      4096 Apr  7 22:34 .
    drwxrwxr-x 3 build build      4096 Apr  7 22:14 ..
    -rw-rw-r-- 2 build build       294 Apr  7 22:30 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
    lrwxrwxrwx 1 build build        73 Apr  7 22:14 bzImage -> bzImage--3.10.34+git0+df3aa753c8_c7739be126-r0-qemux86-20140407203357.bin
    -rw-r--r-- 2 build build   6498704 Apr  7 22:14 bzImage--3.10.34+git0+df3aa753c8_c7739be126-r0-qemux86-20140407203357.bin
    lrwxrwxrwx 1 build build        73 Apr  7 22:14 bzImage-qemux86.bin -> bzImage--3.10.34+git0+df3aa753c8_c7739be126-r0-qemux86-20140407203357.bin
    -rw-r--r-- 1 build build 260506624 Apr  7 22:34 horizon-image-qemux86-20140407203357.rootfs.ext3
    -rw-r--r-- 1 build build     31941 Apr  7 22:33 horizon-image-qemux86-20140407203357.rootfs.manifest
    -rw-r--r-- 1 build build  46944159 Apr  7 22:34 horizon-image-qemux86-20140407203357.rootfs.tar.bz2
    lrwxrwxrwx 1 build build        48 Apr  7 22:34 horizon-image-qemux86.ext3 -> horizon-image-qemux86-20140407203357.rootfs.ext3
    lrwxrwxrwx 1 build build        52 Apr  7 22:34 horizon-image-qemux86.manifest -> horizon-image-qemux86-20140407203357.rootfs.manifest
    lrwxrwxrwx 1 build build        51 Apr  7 22:34 horizon-image-qemux86.tar.bz2 -> horizon-image-qemux86-20140407203357.rootfs.tar.bz2
    -rw-rw-r-- 2 build build  67702787 Apr  7 22:14 modules--3.10.34+git0+df3aa753c8_c7739be126-r0-qemux86-20140407203357.tgz
    lrwxrwxrwx 1 build build        73 Apr  7 22:14 modules-qemux86.tgz -> modules--3.10.34+git0+df3aa753c8_c7739be126-r0-qemux86-20140407203357.tgz
    build@f502df276335:~/tmp/build-horizon-6.0.0-qemux86$

In case the build fails, you may try to clean the offending tasks, as in the following example:

    bitbake -c cleansstate cairo
    
then invoke `bitbake gemini-image` again.

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
