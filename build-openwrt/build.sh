#!/bin/sh

cd $(dirname $0)

docker build --no-cache --rm -t gmacario/build-openwrt .

exit $?
