# ===========================================================================================
# Ubuntu+memcached
# 
# References:
#	https://www.docker.io/learn/dockerfile/level1/
#	https://www.docker.io/learn/dockerfile/level2/
# ===========================================================================================

FROM ubuntu
MAINTAINER Gianpaolo Macario, gmacario@gmail.com

# Make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Install memcached
RUN apt-get install -y memcached

# Run as the following user
USER daemon

# Say hello when the container is launched
#ENTRYPOINT echo "Whale You Be My Container?"
#ENTRYPOINT ["echo", "Whale You Be My Container?"]
#ENTRYPOINT ["wc", "-l"]
#ENTRYPOINT ["memcached", "-u", "daemon"]
ENTRYPOINT ["memcached"]

# Expose memcached port
EXPOSE 11211

# EOF
