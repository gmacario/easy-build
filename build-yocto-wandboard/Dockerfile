# ===========================================================================================
# Dockerfile for building a Yocto-based distro for Wandboard
# 
# References:
#	http://elinux.org/Getting_started_with_Yocto_on_Wandboard
# ===========================================================================================

FROM gmacario/build-yocto

MAINTAINER Gianpaolo Macario, gmacario@gmail.com

## Make sure the package repository is up to date
#RUN apt-get update
#RUN apt-get -y upgrade

## Install packages we cannot leave without...
#RUN apt-get install -y git tig
#RUN apt-get install -y mc
#RUN apt-get install -y openssh-server
## Make sure the directory exists, otherwise sshd will not start
#RUN mkdir -p /var/run/sshd
#RUN apt-get install -y screen

## Install the following utilities (required by poky)
#RUN apt-get install -y make gcc g++ diffstat texinfo gawk chrpath wget

# Install the following utilities (required later)
RUN apt-get install -y curl

## NOTE: Uncomment if user "build" is not already created inside the base image
### Create non-root user that will perform the build of the images
##RUN useradd --shell /bin/bash build
##RUN mkdir -p /home/build
##RUN chown -R build /home/build

# Install "repo" tool
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo

# Clone fsl-community-bsp-platform
RUN mkdir -p /opt/yocto
RUN cd /opt/yocto \
	&& mkdir -p fsl-community-bsp \
	&& cd fsl-community-bsp \
	&& repo init -u https://github.com/Freescale/fsl-community-bsp-platform -b daisy \
	&& repo sync

##RUN cd /home/build

# Define container entry point
ENTRYPOINT ["/bin/bash"]

# Expose sshd port
EXPOSE 22

# EOF
