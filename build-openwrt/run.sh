#!/bin/bash

#set -x

cd $(dirname $0)

if [ "$1" != "" ]; then
    CONTAINER=$1
else
    CONTAINER=build-openwrt
fi
REPOSITORY=gmacario/build-openwrt
SHAREDDIR=$PWD/shared

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
