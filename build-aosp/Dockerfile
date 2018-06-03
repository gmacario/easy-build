# ===========================================================================================
# Dockerfile for building Android Open Source Project
#
# References:
#       http://source.android.com/source/index.html
# ===========================================================================================

# FROM gmacario/easy-build
FROM ubuntu:14.04

MAINTAINER Gianpaolo Macario <gmacario@gmail.com>

# See https://github.com/docker/docker/issues/4032
#ENV DEBIAN_FRONTEND noninteractive

# Make sure the package repository is up to date
RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN dpkg --add-architecture i386
RUN apt-get -qq update && apt-get -qqy dist-upgrade

# Install essential packages
RUN apt-get -y install curl git mc rsync screen tig

# See https://source.android.com/source/initializing.html
#
# The master branch of Android in the Android Open Source Project (AOSP)
# requires Java 8. On Ubuntu, use OpenJDK.
# RUN apt-get -y install openjdk-8-jdk
#
# To develop older versions of Android, download and install the corresponding version of the Java JDK:
#
# Java 7: for Lollipop through Marshmallow
RUN apt-get -y install openjdk-7-jdk
#
# Java 6: for Gingerbread through KitKat
# Java 5: for Cupcake through Froyo
# See http://www.oracle.com/technetwork/java/javase/archive-139210.html
#
# Update the default Java version - optional
#
RUN update-alternatives --config java
RUN update-alternatives --config javac
#
# Installing required packages (Ubuntu 14.04)
#
RUN apt-get -y install git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
  lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
  libgl1-mesa-dev libxml2-utils schedtool xsltproc unzip
#
# Note: To use SELinux tools for policy analysis, also install the python-networkx package.
RUN apt-get -y install python-networkx
#
# Installing required packages (Ubuntu 12.04)
#
# RUN apt-get -y install git gnupg flex bison gperf build-essential \
#   zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
#   libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
#   libgl1-mesa-dev g++-multilib mingw32 tofrodos \
#   python-markdown libxml2-utils xsltproc zlib1g-dev:i386
# RUN ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

# Installing additional packages (required for build_android_udooneo)
RUN apt-get -y install bc lzop u-boot-tools

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
CMD "/bin/bash"

# EOF
