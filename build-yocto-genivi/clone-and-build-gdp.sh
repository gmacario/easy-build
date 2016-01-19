#!/bin/bash

# Sample script to build GDP from sources

set -x
set -e

GDP_URL=git://git.projects.genivi.org/genivi-demo-platform.git
GDP_BRANCH=qemux86-64
WORKDIR=genivi-demo-platform

if [ ! -e $WORKDIR ]; then git clone -b $GDP_BRANCH $GDP_URL $WORKDIR; fi
cd $WORKDIR && git fetch --all --prune
source init.sh
bitbake genivi-demo-platform

# EOF
