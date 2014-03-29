## Building Docker image
```
docker build -t my-build-yocto-genivi .
```

## Running from Docker image repository

```
docker run -t -i gmacario/build-yocto-genivi
su - build
```

## Using the Docker image
(Adapted from http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md)

When logged in as user "build"
```
cd ~/genivi-baseline

PATH_TO_META_IVI=`pwd`
PATH_TO_POKY=`pwd`
source poky/oe-init-build-env

BUILDDIR=`pwd`

cat <<END >>$BUILDDIR/conf/bblayers.conf
BBLAYERS += "$PATH_TO_META_IVI/meta-ivi"
END

cat <<END >>$BUILDDIR/conf/local.conf
#MACHINE ??= "qemuarm"
MACHINE ??= "qemux86"
#MACHINE ??= "qemux86-64"
#
INCOMPATIBLE_LICENSE = "GPLv3"
#
DISTRO_FEATURES += "systemd"
DISTRO ?= "poky-ivi-systemd"
END

bitbake gemini-image
```

### To run the emulator

For QEMU vexpressa9:
```
$PATH_TO_META_IVI/meta-ivi/scripts/runqemu gemini-image vexpressa9
```

For QEMU x86:
```
$PATH_TO_META_IVI/poky/scripts/runqemu gemini-image qemux86
```

For QEMU x86-64:
```
$PATH_TO_META_IVI/poky/scripts/runqemu gemini-image qemux86-x64
```
