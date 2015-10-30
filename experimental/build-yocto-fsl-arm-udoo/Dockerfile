# ===========================================================================================
# Dockerfile for building a Yocto-based distro for Freescale/ARM
# (example: i.MX6Q SABRE, Wandboard, etc.)
# 
# References:
#	http://elinux.org/Getting_started_with_Yocto_on_Wandboard
# ===========================================================================================

FROM gmacario/build-yocto

MAINTAINER Iwan Sanders, iwan.sanders@gmail.com

# Install the following utilities (required later)
RUN apt-get install -y curl

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

RUN cd /opt/yocto/fsl-community-bsp/sources \
    && git clone https://github.com/rongals/meta-ronga-udoo.git --recursive


RUN echo "MACHINE=\"udoo-quad\"" >> ~/.bashrc
RUN echo "YOCTO=/opt/yocto" >> ~/.bashrc

# Define container entry point
ENTRYPOINT ["/bin/bash"]

# Expose sshd port
EXPOSE 22

# EOF
