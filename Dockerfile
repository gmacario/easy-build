# Ubuntu+memcached
# From https://www.docker.io/learn/dockerfile/level1/

FROM ubuntu
MAINTAINER Gianpaolo Macario, gmacario@gmail.com

# Make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Install memcached
RUN apt-get install -y memcached

# EOF
