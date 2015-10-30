#!/bin/sh

set -x

cd $(dirname $0)

docker build --no-cache --rm -t iwansanders/build-yocto-fsl-arm-udoo .

exit $?
