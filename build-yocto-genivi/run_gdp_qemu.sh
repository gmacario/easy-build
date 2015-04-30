#!/bin/bash

set -x

export SHARED=${HOME}/easy-build/build-yocto-genivi/shared
source ${SHARED}/sources/poky/oe-init-build-env ${SHARED}/my-gdp-build03

cd ${BUILDDIR}/tmp/deploy/images/qemux86-64
runqemu \
bzImage-qemux86-64.bin \
genivi-demo-platform-qemux86-64.ext3 \
qemuparams="-soundhw ac97"

# EOF
