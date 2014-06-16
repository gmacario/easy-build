#!/bin/sh

# Mirror directory BASE_SYNC from REMOTE_WORKDIR to LOCAL_WORKDIR

#set -x
set -e

REMOTE_WORKDIR=gmacario@maxlab.polito.it:~/easy-build/build-yocto-fsl-arm/shared
LOCAL_WORKDIR=shared

BASE_SYNC=""
BASE_SYNC="${BASE_SYNC} build-imx6qsabresd/tmp/deploy"
BASE_SYNC="${BASE_SYNC} build-wandboard-dual/tmp/deploy"
#BASE_SYNC="${BASE_SYNC} build-xxxx/tmp/deploy"

echo INFO: Mirroring from ${REMOTE_WORKDIR}
echo INFO: Mirroring to ${LOCAL_WORKDIR}

for d in ${BASE_SYNC}; do
    echo INFO: Syncing ${d}
    mkdir -p ${LOCAL_WORKDIR}/${d}
    rsync -avz --delete --progress ${REMOTE_WORKDIR}/${d}/ ${LOCAL_WORKDIR}/${d}
done

# === EOF ===
