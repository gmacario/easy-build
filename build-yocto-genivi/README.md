## Locally rebuilding Docker image from Dockerfile and running it

    docker build -t my-build-yocto-genivi .
    docker run -t -i my-build-yocto-genivi
    su - build

## Pulling image from public Docker index and running it

    docker pull gmacario/build-yocto-genivi
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

    # Known SHA for Yocto GENIVI Baseline 5.0.2
    # See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=5.0.2
    #cd $TOPDIR/meta-ivi && git checkout 5.0.2
    #cd $TOPDIR/poky     && git checkout 53d2563ff13fcec74d4250bef5419e36169e55cc
    
    # Known SHA for Yocto GENIVI Baseline 5.0.1
    # See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=5.0.1
    #cd $TOPDIR/meta-ivi && git checkout 5.0.1
    #cd $TOPDIR/poky     && git checkout 53d2563ff13fcec74d4250bef5419e36169e55cc
    
    # Known SHA for Yocto GENIVI Baseline 5.0.0
    # See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=5.0.0
    cd $TOPDIR/meta-ivi && git checkout 5.0.0
    cd $TOPDIR/poky     && git checkout 56f39bcf2237c11508d82238b6292e4bfbfed764
    
    cat <<END >>$BUILDDIR/conf/bblayers.conf
    BBLAYERS += " \
      $TOPDIR/meta-ivi \
      $TOPDIR/meta-ivi/meta-ivi-bsp \
      "
    END
    
    cat <<END >>$BUILDDIR/conf/local.conf
    # Override config options in conf/local.conf
    BB_NUMBER_THREADS = "4"
    PARALLEL_MAKE = "-j 4"
    #
    DISTRO = "poky-ivi-systemd"
    #DISTRO_FEATURES_append = " opengl"
    #DISTRO_FEATURES_append = " pam"
    #DISTRO_FEATURES_append = " systemd"
    #DISTRO_FEATURES_append = " x11"
    #
    MACHINE ?= "vexpressa9"
    #MACHINE ?= "qemux86"
    #MACHINE ?= "qemux86-64"
    #
    #PREFERRED_VERSION_linux-yocto_vexpressa9 = "3.10.11"
    #
    INCOMPATIBLE_LICENSE = "GPLv3"
    END

For help about syntax of `conf/bblayers.conf` and `conf/local.conf` please refer to the [Yocto Project Documentation](http://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html)

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
