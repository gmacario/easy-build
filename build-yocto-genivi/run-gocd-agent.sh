#!/bin/bash
# Run as a GoCD Agent

set -x
set -e

git config --global user.name "easy-build"
git config --global user.email "$(whoami)@$(hostname)"

cp /etc/default/go-agent go-agent.ORIG
sed 's/^GO_SERVER=.*$/GO_SERVER=go.genivi.org/g' go-agent.ORIG >/etc/default/go-agent
service go-agent start

# EOF
