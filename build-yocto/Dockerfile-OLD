# ===========================================================================================
# Dockerfile for building the Yocto Project
# 
# References:
#	http://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html
# ===========================================================================================

FROM gmacario/build-in-jenkins-slave:latest
MAINTAINER Gianpaolo Macario <gmacario@gmail.com>

# Make sure the package repository is up to date
USER root
RUN apt-get update && apt-get -y upgrade

# Install packages we cannot leave without...
RUN apt-get install -y git mc tig tree
RUN apt-get install -y openssh-server
# Make sure the directory exists, otherwise sshd will not start
RUN mkdir -p /var/run/sshd
RUN apt-get install -y screen

# Install the following utilities (required by poky)
RUN apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath libsdl1.2-dev xterm

# Additional host packages required by poky/scripts/wic
# TODO: Understand how to build them using the -native recipes
RUN apt-get install -y parted dosfstools mtools syslinux

# Add "repo" tool (used by many Yocto-based projects)
RUN curl http://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo

RUN mkdir -p /shared

# TODO: Run as user "build" once Docker supports user-level volumes
#RUN su -c "mkdir -p ~/yocto" build
#RUN su -c "cd ~ && git clone git://git.yoctoproject.org/poky" build
#ENTRYPOINT ["/bin/su", "-l", "build"]

ENTRYPOINT ["/bin/bash"]

# Expose sshd port
EXPOSE 22

# EOF
