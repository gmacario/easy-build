#!/bin/sh

#set -x

cd $(dirname $0)

SHAREDDIR=$PWD/shared
CONTAINER=build-yocto-genivi
REPOSITORY=gmacario/build-yocto-genivi

# Create a shared folder which will be used as working directory.
mkdir -p $SHAREDDIR

# Try to start an existing/stopped container with the given name $CONTAINER.
# Otherwise, run a new one.
docker start -i $CONTAINER || \
	docker run -v $SHAREDDIR:/home/build/shared -i -t \
	--name $CONTAINER $REPOSITORY
# /bin/sh -c "screen -s /bin/bash"

exit $?
