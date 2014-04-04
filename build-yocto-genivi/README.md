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

### Switching to build user

    chown build.build /home/build/tmp
    su - build

### Initialize build environment

After logging in as user "build" execute the following commands:

    GENIVI=~/genivi-baseline
    source $GENIVI/poky/oe-init-build-env ~/tmp/my-genivi-build
    TOPDIR=$PWD

### Building the GENIVI image

#### Configure build

The following commands must be executed only once:

    # Known SHA for Yocto GENIVI Baseline 5.0.2
    # See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=5.0.2
    cd $GENIVI/meta-ivi && git checkout 5.0.2
    cd $GENIVI/poky     && git checkout 53d2563ff13fcec74d4250bef5419e36169e55cc
    
    # Known SHA for Yocto GENIVI Baseline 5.0.1
    # See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=5.0.1
    #cd $GENIVI/meta-ivi && git checkout 5.0.1
    #cd $GENIVI/poky     && git checkout 53d2563ff13fcec74d4250bef5419e36169e55cc
    
    # Known SHA for Yocto GENIVI Baseline 5.0.0
    # See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=5.0.0
    #cd $GENIVI/meta-ivi && git checkout 5.0.0
    #cd $GENIVI/poky     && git checkout 56f39bcf2237c11508d82238b6292e4bfbfed764
    
    cd $TOPDIR
    
    cp $TOPDIR/conf/bblayers.conf $TOPDIR/conf/bblayers.conf.ORIG
    cat <<END >>$TOPDIR/conf/bblayers.conf
    BBLAYERS += " \
      $GENIVI/meta-ivi \
      $GENIVI/meta-ivi/meta-ivi-bsp \
      "
    END
    
    cp $TOPDIR/conf/local.conf $TOPDIR/conf/local.conf.ORIG
    cat <<END >>$TOPDIR/conf/local.conf
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

For help about syntax of `conf/bblayers.conf` and `conf/local.conf` please refer to the [Yocto Project Documentation](http://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html).

#### Perform build

    cd $TOPDIR
    bitbake -k gemini-image

**NOTE**: This command may take a few hours to complete.

If the build is successful, the following files should be created under $TOPDIR/tmp/deploy:

    build@70b343514a7e:~/genivi-baseline/build$ ls -la tmp/deploy/images/qemux86/
    total 261772
    drwxrwxr-x 2 build build      4096 Mar 30 15:54 .
    drwxrwxr-x 3 build build      4096 Mar 30 15:35 ..
    -rw-rw-r-- 2 build build       294 Mar 30 15:50 README_-_DO_NOT_DELETE_FILES_IN_THIS_DIRECTORY.txt
    lrwxrwxrwx 2 build build        73 Mar 30 15:35 bzImage -> bzImage--3.10.11+git0+dad2b7e1ce_e1aa804148-r2-qemux86-20140330142316.bin
    -rw-r--r-- 2 build build   6195776 Mar 30 15:35 bzImage--3.10.11+git0+dad2b7e1ce_e1aa804148-r2-qemux86-20140330142316.bin
    lrwxrwxrwx 2 build build        73 Mar 30 15:35 bzImage-qemux86.bin -> bzImage--3.10.11+git0+dad2b7e1ce_e1aa804148-r2-qemux86-20140330142316.bin
    -rw-r--r-- 1 build build 254164992 Mar 30 15:54 gemini-image-qemux86-20140330142316.rootfs.ext3
    -rw-r--r-- 1 build build  47327430 Mar 30 15:54 gemini-image-qemux86-20140330142316.rootfs.tar.bz2
    lrwxrwxrwx 1 build build        47 Mar 30 15:54 gemini-image-qemux86.ext3 -> gemini-image-qemux86-20140330142316.rootfs.ext3
    lrwxrwxrwx 1 build build        50 Mar 30 15:54 gemini-image-qemux86.tar.bz2 -> gemini-image-qemux86-20140330142316.rootfs.tar.bz2
    -rw-rw-r-- 2 build build  54414397 Mar 30 15:35 modules--3.10.11+git0+dad2b7e1ce_e1aa804148-r2-qemux86-20140330142316.tgz
    lrwxrwxrwx 2 build build        73 Mar 30 15:35 modules-qemux86.tgz -> modules--3.10.11+git0+dad2b7e1ce_e1aa804148-r2-qemux86-20140330142316.tgz
    build@70b343514a7e:~/genivi-baseline/build$

In case the build fails, you may try to clean the offending tasks, as in the following example:

    bitbake -c cleansstate cairo
    
then invoke `bitbake gemini-image` again.

### Running the created images with QEMU

#### For QEMU vexpressa9

    $GENIVI/meta-ivi/scripts/runqemu gemini-image vexpressa9

#### For QEMU x86

    $GENIVI/poky/scripts/runqemu gemini-image qemux86

#### For QEMU x86-64

    $GENIVI/poky/scripts/runqemu gemini-image qemux86-x64
    
## Committing the image with the pre-built Yocto GENIVI Baseline

If the previous commands were successful, exit the container, then execute the following commands to persist the container into a Docker image:

    CONTAINER_ID=$(docker ps -lq)
    docker commit -m "John Doe <john.doe@me.com>" $CONTAINER_ID <repository:tag>

You may optionally push the image to a public Docker repository, like

    docker push <repository>
