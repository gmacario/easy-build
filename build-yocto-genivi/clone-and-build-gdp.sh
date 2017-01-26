#!/bin/bash

# Sample script to build GDP from sources

set -x
set -e

GDP_URL=https://github.com/GENIVI/genivi-dev-platform.git
GDP_BRANCH=master
# GDP_SHA=707eddc0f6f76488fb2c566bf998d63ec7e2ae9b
MACHINE=qemux86-64

WORKDIR=genivi-dev-platform
[ "$GDP_SHA" != "" ] && WORKDIR=$WORKDIR-$GDP_SHA

git config --global user.name "easy-build"
git config --global user.email "$(whoami)@$(hostname)"

if [ ! -e $WORKDIR ]; then git clone -b $GDP_BRANCH $GDP_URL $WORKDIR; fi
cd $WORKDIR && git fetch --all --prune
[ "$GDP_SHA" != "" ] && git checkout $GDP_SHA
git show
git status

source init.sh ${MACHINE}
bitbake genivi-dev-platform

# EOF
