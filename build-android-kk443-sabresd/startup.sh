#!/bin/bash

echo "DEBUG: startup.sh BEGIN"

set -e

# Not sure why the following packages
# are not installed inside the container
which gcc || sudo apt-get -y install build-essential

# Install JDK 6
if [ ! -e /root/.jdk6_installed ]; then
    echo "INFO: Installing JDK 6"
    mkdir -p /opt/java
    cd /opt/java
    rm -rf /opt/java/jdk1.6.0_45
    ~build/shared/jdk-6u45-linux-x64.bin
    echo 'PATH=/opt/java/jdk1.6.0_45/bin:$PATH' >>~build/.profile
    chown build ~build/.profile
    cd
    touch /root/.jdk6_installed
fi

mkdir -p ~build/shared/extra
chown build.build ~build/shared/extra
mkdir -p ~build/shared/myandroid
chown build.build ~build/shared/myandroid

if [ -e "/home/build/startup2.sh" ]; then
    echo "DEBUG: Running startup2.sh as build"
    su -l -c "/home/build/startup2.sh" build
fi

# Open a debugging shell
#su -l build
#/bin/bash -l
/bin/bash

echo "DEBUG: startup.sh END"

# EOF
