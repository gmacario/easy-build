#!/bin/sh

# Project: easy-build
# Mirror directory BASE_SYNC from REMOTE_WORKDIR to LOCAL_WORKDIR
# You may need to configure parameters at the top of the script

REMOTE_WORKDIR=gmacario@maxlab.polito.it:~/easy-build/build-yocto-fsl-arm/shared
LOCAL_WORKDIR=shared

BASE_SYNC=""
BASE_SYNC="${BASE_SYNC} build-imx6qsabresd/tmp/deploy"
BASE_SYNC="${BASE_SYNC} build-wandboard-dual/tmp/deploy"
#BASE_SYNC="${BASE_SYNC} build-xxxx/tmp/deploy"

#set -x
set -e

echo INFO: Mirroring from: ${REMOTE_WORKDIR}
echo INFO: Mirroring to: ${LOCAL_WORKDIR}

for d in ${BASE_SYNC}; do
    echo INFO: Syncing ${d}
    mkdir -p ${LOCAL_WORKDIR}/${d}
    rsync -az -h --progress --delete ${REMOTE_WORKDIR}/${d}/ ${LOCAL_WORKDIR}/${d} || {
        echo ERROR Syncing ${d}
    }
done

# === EOF ===
