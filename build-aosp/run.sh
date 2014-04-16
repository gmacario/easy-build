#!/bin/sh

#set -x

cd $(dirname $0)

TMPDIR=$PWD/tmp
CONTAINER=build-aosp
REPOSITORY=gmacario/build-aosp

# Create a shared folder which will be used as working directory.
mkdir -p $TMPDIR

# Try to start an existing/stopped container with the given name $CONTAINER.
# Otherwise, run a new one.
docker start -i $CONTAINER || \
	docker run -v $TMPDIR:/home/build/tmp -i -t \
	--name $CONTAINER $REPOSITORY
# /bin/sh -c "screen -s /bin/bash"

exit $?
