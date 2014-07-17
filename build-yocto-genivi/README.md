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

Review `configure_build.sh` and make any modifications if needed, then invoke the script

    sh configure_build.sh

For help about syntax of `conf/bblayers.conf` and `conf/local.conf` please refer to the
[Yocto Project Documentation](http://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html).

#### Perform build

    cd $TOPDIR
    bitbake -k horizon-image

**NOTE**: This command may take a few hours to complete.

Sample output:
```
build@7cf7d23b0b92:~/tmp/my-genivi-build$ bitbake -k horizon-image
Loading cache: 100% |#################################################################| ETA:  00:00:00
Loaded 1248 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        = "1.22.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "i586-poky-linux"
MACHINE           = "qemux86"
DISTRO            = "poky-ivi-systemd"
DISTRO_VERSION    = "6.0.2"
TUNE_FEATURES     = "m32 i586"
TARGET_FPU        = ""
meta
meta-yocto
meta-yocto-bsp    = "(detachedfrom8e05d5e):8e05d5e3fe04face623c4f9fb08b12f13c22edab"
meta-ivi
meta-ivi-bsp
meta-ivi
meta-ivi-bsp
meta-ivi
meta-ivi-bsp      = "(detachedfrom6.0.2):e4ba89c742447b458c15e3bf8e7ce415fffbdc0b"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
NOTE: Tasks Summary: Attempted 2908 tasks of which 2908 didn't need to be rerun and all succeeded.
build@7cf7d23b0b92:~/tmp/my-genivi-build$
```
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
