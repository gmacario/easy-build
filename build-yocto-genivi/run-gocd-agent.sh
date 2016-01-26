#!/bin/bash
# Run as a GoCD Agent

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

git config --global user.name "easy-build"
git config --global user.email "$(whoami)@$(hostname)"

cp /etc/default/go-agent go-agent.ORIG
sed 's/^GO_SERVER=.*$/GO_SERVER=go.genivi.org/g' go-agent.ORIG >/etc/default/go-agent
service go-agent start

# EOF
