#!/bin/bash

#set -x

cd $(dirname $0)

SHARED=$PWD/shared
#SOURCE=$(pwd)/shared/android
CCACHE=$(pwd)/shared/ccache
CONTAINER_HOME=/home/build
CONTAINER=$(basename $PWD)
REPOSITORY=gmacario/$(basename $PWD)
TAG=latest
[ "$FORCE_BUILD" == "" ] && FORCE_BUILD=0

# Create shared folders
mkdir -p $SHARED
mkdir -p $CCACHE

# Build image if needed
IMAGE_EXISTS=$(docker images $REPOSITORY)
if [ $? -ne 0 ]; then
	echo "docker command not found"
	exit $?
elif [[ $FORCE_BUILD = 1 ]] || ! echo "$IMAGE_EXISTS" | grep -q "$TAG"; then
	echo "Building Docker image $REPOSITORY:$TAG..."
	docker build -t $REPOSITORY:$TAG .

	# After successful build, delete existing containers
	IS_EXISTING=$(docker inspect -f '{{.Id}}' $CONTAINER 2>/dev/null)
	if [[ -n "$IS_EXISTING" ]]; then
		docker rm $CONTAINER
	fi
fi

# With the given name $CONTAINER, reconnect to running container, start
# an existing/stopped container or run a new one if one does not exist.
IS_RUNNING=$(docker inspect -f '{{.State.Running}}' $CONTAINER 2>/dev/null)
if [[ $IS_RUNNING == "true" ]]; then
	docker attach $CONTAINER
elif [[ $IS_RUNNING == "false" ]]; then
	docker start -i $CONTAINER
else
	docker run -v $SHARED:$CONTAINER_HOME/shared -v $CCACHE:/srv/ccache -i -t --name $CONTAINER $REPOSITORY:$TAG
fi

exit $?
