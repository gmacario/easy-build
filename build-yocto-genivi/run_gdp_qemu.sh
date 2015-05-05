#!/bin/bash

#set -x

export SHARED=$(dirname $(readlink -f $0))/shared
source ${SHARED}/sources/poky/oe-init-build-env ${SHARED}/my-gdp-build04

if [ "$DISPLAY" = "" ]; then
    echo "WARNING: No DISPLAY set, running in nographic mode"
    runqemu qemux86-64 tmp/deploy/images/qemux86-64/genivi-demo-platform-qemux86-64.ext3 nographic
else
    echo "DEBUG: DISPLAY=$DISPLAY, running in graphic mode"
    # VGA graphics (only works from Ubuntu desktop)
    export QEMU_AUDIO_DRV=pa
    cd ${BUILDDIR}/tmp/deploy/images/qemux86-64
    ${SHARED}/sources/meta-genivi-demo/scripts/runqemu \
        bzImage-qemux86-64.bin \
        genivi-demo-platform-qemux86-64.ext3 \
        qemuparams="-soundhw ac97"
fi

# EOF
