# ===========================================================================================
# Base Dockerfile for building embedded distros
# 
# References:
#	https://www.docker.io/learn/dockerfile/level1/
#	https://www.docker.io/learn/dockerfile/level2/
# ===========================================================================================

FROM ubuntu:12.04
MAINTAINER Arthur Taylor, arthur@advancedtelematic.com

# Make sure the package repository is up to date
RUN apt-get update

# Install required packages
RUN apt-get install -y git tig mc
RUN apt-get install -y make gcc g++ diffstat texinfo gawk chrpath wget python libsdl1.2-dev curl bzip2

# Create non-root user that will perform the build of the images
RUN useradd --shell /bin/bash build
RUN mkdir -p /home/build
RUN chown -R build /home/build

# Download and build GDP Code from Gunnar's repo
RUN su -c "cd ~ && git clone --recursive https://github.com/gunnarx/genivi-demo-platform.git -b qemux86-64" build
RUN su -c "cd ~/genivi-demo-platform && source init.sh && bitbake genivi-demo-platform" build

RUN cd /home/build

# Run as the following user
USER build

ENTRYPOINT ["/bin/bash"]
