#!/bin/bash

# ===========================================================================
# Project: gmacario/easy-build
#
# Run as a GoCD Agent
#
# Example of usage
#
# $ docker run -d --user=go \
#   --hostname my-genivigo-testagent \
#   --workdir /var/lib/go-agent \
#   gmacario/build-yocto-genivi /usr/local/bin/run-gocd-agent.sh
# ===========================================================================

# set -x
set -e

# Sanity checks

if [ $(whoami) != 'go' ]; then
    echo "Please specify docker run --user go"
    exit 1
fi
if [ $(pwd) != '/var/lib/go-agent' ]; then
    echo "Please specify docker run --workdir /var/lib/go-agent"
    exit 1
fi
if [ "${GO_SERVER}" == "" ]; then
    export GO_SERVER=go.genivi.org
    echo "GO_SERVER was not defined - setting to ${GO_SERVER}"
fi

git config --global user.name "easy-build"
git config --global user.email "$(whoami)@$(hostname)"

cp /etc/default/go-agent go-agent.ORIG
sed "s/^GO_SERVER=.*$/GO_SERVER=${GO_SERVER}/g" go-agent.ORIG >/etc/default/go-agent
service go-agent start

# EOF
