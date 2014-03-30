## Locally rebuilding Docker image from Dockerfile and running it

    docker build -t my-build-yocto-genivi .
    docker run -t -i my-build-yocto-genivi
    su - build

## Pulling image from public Docker index and running it

    docker run -t -i gmacario/build-yocto-genivi
    su - build

## Using the Docker image

Adapted from http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md

### Initialize build environment

After logging in as user "build" execute the following commands:

    cd ~/genivi-baseline
    TOPDIR=$PWD
    source poky/oe-init-build-env
    BUILDDIR=$PWD

### Building the GENIVI image

#### Configure build

This action is needed only the first time

    cd $TOPDIR/poky     && git checkout 53d2563ff13fcec74d4250bef5419e36169e55cc
    cd $TOPDIR/meta-ivi && git checkout 5.0.2
        
    cat <<END >>$BUILDDIR/conf/bblayers.conf
    BBLAYERS += "$TOPDIR/meta-ivi"
    END
    
    cat <<END >>$BUILDDIR/conf/local.conf
    # Override config options in conf/local.conf
    BB_NUMBER_THREADS ?= "4"
    PARALLEL_MAKE ?= "-j 4"
    #
    MACHINE ??= "qemuarm"
    #MACHINE ??= "qemux86"
    #MACHINE ??= "qemux86-64"
    #
    INCOMPATIBLE_LICENSE = "GPLv3"
    #
    DISTRO ?= "poky-ivi-systemd"
    DISTRO_FEATURES_append = " opengl systemd x11"
    END

#### Perform build

    cd $BUILDDIR
    bitbake -k gemini-image

**NOTE**: This command may take a few hours to complete.

As a result the following files should be created under $BUILDDIR/TODO:

* TODO

### Running the created images with QEMU

#### For QEMU vexpressa9

    $TOPDIR/meta-ivi/scripts/runqemu gemini-image vexpressa9

#### For QEMU x86

    $TOPDIR/poky/scripts/runqemu gemini-image qemux86

#### For QEMU x86-64

    $TOPDIR/poky/scripts/runqemu gemini-image qemux86-x64
