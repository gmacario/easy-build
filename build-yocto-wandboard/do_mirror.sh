#!/bin/sh

# Mirror directory BASE_SYNC from REMOTE_WORKDIR to LOCAL_WORKDIR

set -x
set -e

REMOTE_WORKDIR=gmacario@maxlab.polito.it:~/easy-build/build-yocto-wandboard/work
LOCAL_WORKDIR=work

BASE_SYNC=build-wandboard-dual/tmp/deploy

mkdir -p ${LOCAL_WORKDIR}/${BASE_SYNC}
rsync -avz ${REMOTE_WORKDIR}/${BASE_SYNC}/ ${LOCAL_WORKDIR}/${BASE_SYNC}

# === EOF ===
