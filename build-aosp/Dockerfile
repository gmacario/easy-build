# ===========================================================================================
# Dockerfile for building Android Open Source Project
# 
# References:
#	http://source.android.com/source/index.html
# ===========================================================================================

# FROM gmacario/easy-build
FROM ubuntu:14.04

MAINTAINER Gianpaolo Macario <gmacario@gmail.com>

# See https://github.com/docker/docker/issues/4032
#ENV DEBIAN_FRONTEND noninteractive

# Make sure the package repository is up to date
RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN dpkg --add-architecture i386 && apt-get -qq update && apt-get -qqy dist-upgrade

# Install essential packages
RUN apt-get -y install curl git mc rsync screen tig

# See https://source.android.com/source/initializing.html
#
# The master branch of Android in the Android Open Source Project (AOSP)
# requires Java 7. On Ubuntu, use OpenJDK.
# To develop older versions of Android, download and install
# the corresponding version of the Java JDK (not OpenJDK):
# * Java 6: for Gingerbread through KitKat
# * Java 5: for Cupcake through Froyo
#
#RUN apt-get install -y openjdk-7-jdk
#
#RUN update-alternatives --config java
#RUN update-alternatives --config javac
#
# Installing required packages (Ubuntu 14.04)
#
RUN apt-get -y install bc bison build-essential ccache flex \
    g++-multilib gcc-multilib git gperf \
    lib32stdc++6 lib32z1 lib32z1-dev liblzo2-dev \
    libxml2-utils lzop make python \
    u-boot-tools uuid-dev zip zlib1g-dev:i386

#RUN apt-get -y install git gnupg flex bison gperf build-essential \
#  zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
#  libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
#  libgl1-mesa-dev g++-multilib mingw32 tofrodos \
#  python-markdown libxml2-utils xsltproc zlib1g-dev:i386
#RUN ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 \
#	/usr/lib/i386-linux-gnu/libGL.so

# Optional: Install apt-file to find which package provides a given file
#RUN apt-get -y install apt-file
#RUN apt-file update

# Add "repo" tool
RUN curl http://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo

# Create user "jenkins"
RUN id jenkins 2>/dev/null || useradd --uid 1000 --create-home --shell /bin/bash jenkins

# Create a non-root user that will perform the actual build
RUN id build 2>/dev/null || useradd --uid 30000 --create-home --shell /bin/bash build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

USER build
WORKDIR /home/build
CMD "/bin/bash"1

# EOF
