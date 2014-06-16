#!/bin/sh

#set -x

cd $(dirname $0)

TMPDIR=$PWD/shared
CONTAINER=build-yocto-fsl-arm
REPOSITORY=gmacario/build-yocto-fsl-arm

# Create a shared folder which will be used as working directory.
mkdir -p $TMPDIR

# Try to start an existing/stopped container with the given name $CONTAINER.
# Otherwise, run a new one.
docker start -i $CONTAINER || \
	docker run -v $TMPDIR:/shared -i -t \
	--name $CONTAINER $REPOSITORY
# /bin/sh -c "screen -s /bin/bash"

exit $?
