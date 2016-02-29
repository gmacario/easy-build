#!/bin/bash

# Sample script to build GDP from sources

set -x
set -e

GDP_URL=git://git.projects.genivi.org/genivi-demo-platform.git
GDP_BRANCH=qemux86-64
# GDP_SHA=811273dd0984169605bf216046cdf3c9a88448c6

WORKDIR=genivi-demo-platform
[ "$GDP_SHA" != "" ] && WORKDIR=$WORKDIR-$GDP_SHA

git config --global user.name "easy-build"
git config --global user.email "$(whoami)@$(hostname)"

if [ ! -e $WORKDIR ]; then git clone -b $GDP_BRANCH $GDP_URL $WORKDIR; fi
cd $WORKDIR && git fetch --all --prune
[ "$GDP_SHA" != "" ] && git checkout $GDP_SHA
git show
git status

source init.sh
bitbake genivi-demo-platform

# EOF
