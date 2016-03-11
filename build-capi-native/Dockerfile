FROM ubuntu:16.04

MAINTAINER Gianpaolo Macario <gianpaolo_macario@mentor.com>

RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install autoconf build-essential file git libtool make sudo
RUN apt-get -y install libsystemd-dev pkg-config
RUN id build 2>/dev/null || useradd -m build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

# EOF
