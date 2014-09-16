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
TODO
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
