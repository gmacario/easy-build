#!/bin/bash

#set -x

cd $(dirname $0)

SHAREDDIR=$PWD/shared
CONTAINER=build-openwrt
REPOSITORY=gmacario/build-openwrt

# Create a shared folder which will be used as working directory.
mkdir -p $SHAREDDIR

# Try to start an existing/stopped container with the given name $CONTAINER.
# Otherwise, run a new one.
if docker inspect $CONTAINER >/dev/null 2>&1; then
    echo -e "\nINFO: Reattaching to running container\n"
    docker start -i $CONTAINER
else
    echo -e "\nINFO: Creating a new container\n"
    docker run -v $SHAREDDIR:/shared -i -t \
	--name $CONTAINER $REPOSITORY
fi

# /bin/sh -c "screen -s /bin/bash"

exit $?
