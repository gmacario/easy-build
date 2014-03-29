## Rebuilding container from Dockerfile

```
docker build -t my-build-yocto-genivi .
docker run -t -i my-build-yocto-genivi
su - build
```

## Running container from public Docker index

```
docker run -t -i gmacario/build-yocto-genivi
su - build
```

## Using the Docker image

Adapted from http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md

When logged in as user "build"

```
cd ~/genivi-baseline
TOPDIR=`pwd`

source poky/oe-init-build-env
BUILDDIR=`pwd`

cd $TOPDIR/poky \
    && git checkout 53d2563ff13fcec74d4250bef5419e36169e55cc
cd $topdir/meta-ivi \
    && git checkout 5.0.2
    
cat <<END >>$BUILDDIR/conf/bblayers.conf
BBLAYERS += "$TOPDIR/meta-ivi"
END

cat <<END >>$BUILDDIR/conf/local.conf
#MACHINE ??= "qemuarm"
MACHINE ??= "qemux86"
#MACHINE ??= "qemux86-64"
#
INCOMPATIBLE_LICENSE = "GPLv3"
#
DISTRO ?= "poky-ivi-systemd"
#
DISTRO_FEATURES += "opengl"
DISTRO_FEATURES += "systemd"
DISTRO_FEATURES += "x11"
END

cd $BUILDDIR
bitbake gemini-image
```

### To run the emulator

For QEMU vexpressa9:
```
$TOPDIR/meta-ivi/scripts/runqemu gemini-image vexpressa9
```

For QEMU x86:
```
$TOPDIR/poky/scripts/runqemu gemini-image qemux86
```

For QEMU x86-64:
```
$TOPDIR/poky/scripts/runqemu gemini-image qemux86-x64
```
