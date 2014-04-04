#!/bin/bash

# Execute gemini-image under qemu-system-i386

# Inspired by
#    http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/scripts/runqemu

# Notice that scripts/runqemu on poky master support VM=path/to/<image>-<machine>.vmdk

set -e

TOPDIR=$PWD/tmp/build-gemini-5.0.0-qemux86

MACHINE=qemux86
FSTYPE=ext3
KERNEL=$TOPDIR/tmp/deploy/images/$MACHINE/bzImage-$MACHINE.bin
ROOTFS=$TOPDIR/tmp/deploy/images/$MACHINE/gemini-image-$MACHINE.$FSTYPE

if [ ! -w "$ROOTFS" ]; then
    ROOTFS_COPY=./my_rootfs.ext3
    echo "ROOTFS is r/o, make a copy as $ROOTFS_COPY"
    cp $ROOTFS $ROOTFS_COPY
    export ROOTFS=$ROOTFS_COPY
fi

# TODO: What is /dev/net/tun for???

#QEMUX86_DEFAULT_KERNEL=bzImage-qemux86.bin
#QEMUX86_DEFAULT_FSTYPE=ext3

#INTERNAL_SCRIPT=`$0-internal"
#INTERNAL_SCRIPT=`which runqemu-internal`

# Inspired by
#    http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/scripts/runqemu-internal

QEMUOPTIONS="$QEMUOPTIONS -monitor stdio"
SERIALOPTS=""

SCRIPT_QEMU_OPT=""
SCRIPT_QEMU_EXTRA_OPT=""

mem_size=256
QEMU_MEMORY="$mem_size"M

QEMU=qemu-system-i386

#QEMU_UI_OPTIONS="$QEMU_UI_OPTIONS -nographic"
#QEMU_UI_OPTIONS="$QEMU_UI_OPTIONS -vga none"
QEMU_UI_OPTIONS="$QEMU_UI_OPTIONS -vga vmware"

CPU_SUBTYPE=qemu32

#(case "$KVM_ACTIVE" != "yes)
QEMU_NETWORK_CMD=""
DROOT="/dev/hda"
ROOTFS_OPTIONS="-hda $ROOTFS"

#(case "$FSTYPE" = "ext3")
KERNCMDLINE="vga=0 uvesafb.mode_option=640x480-32 root=$DROOT rw mem=$QEMU_MEMORY $KERNEL_NETWORK_CMD"
QEMUOPTIONS="$QEMU_NETWORK_CMD -cpu $CPU_SUBTYPE $ROOTFS_OPTIONS $QEMU_UI_OPTIONS"

#KERNCMDLINE="$KERNCMDLINE debug"
SCRIPT_KERNEL_OPT=""

QEMUBIN=`which $QEMU` 2> /dev/null
if [ ! -x "$QEMUBIN" ]; then
    echo "Error: No QEMU binary '$QEMU' could be found."
    cleanup
    return 1
fi

echo "Running $QEMU..."
set -x
$QEMUBIN -kernel $KERNEL $QEMUOPTIONS $SERIALOPTS -no-reboot $SCRIPT_QEMU_OPT $SCRIPT_QEMU_EXTRA_OPT --append "$KERNCMDLINE $SCRIPT_KERNEL_OPT"

# EOF
