# ===========================================================================================
# Base Dockerfile for building embedded distros
# 
# References:
#	https://www.docker.io/learn/dockerfile/level1/
#	https://www.docker.io/learn/dockerfile/level2/
# ===========================================================================================

FROM gmacario/baseimage:0.9.15b
MAINTAINER Gianpaolo Macario, gmacario@gmail.com

# Make sure the package repository is up to date
RUN apt-get update && apt-get -y upgrade

# Install required packages
RUN apt-get install -y git mc tig

# Create non-root user that will perform the build of the images
RUN useradd --shell /bin/bash build && mkdir -p /home/build && chown -R build /home/build

# Leave derived dockerfiles to download source repositories
# RUN cd /home/build

# Run as the following user
# USER daemon

ENTRYPOINT ["/bin/bash"]

# EOF
