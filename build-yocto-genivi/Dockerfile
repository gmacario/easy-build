# ===========================================================================================
# Dockerfile for building the Yocto GENIVI Baseline
# 
# References:
#	http://projects.genivi.org/GENIVI_Baselines/meta-ivi/home
#	https://www.docker.io/learn/dockerfile/level1/
#	https://www.docker.io/learn/dockerfile/level2/
# ===========================================================================================

FROM ubuntu
MAINTAINER Gianpaolo Macario, gmacario@gmail.com

# Make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Install required packages
RUN apt-get install -y git tig
RUN apt-get install -y mc

# Create non-root user that will perform the build of the images
RUN useradd --shell /bin/bash build
RUN mkdir -p /home/build
RUN chown -R build /home/build

# Clone meta-ivi and poky repos
RUN su -c "cd ~ && git clone git://git.yoctoproject.org/meta-ivi \
	&& cd meta-ivi && git checkout master" build
RUN su -c "cd ~ && git clone git://git.yoctoproject.org/poky \
	&& cd poky && git checkout 44c3f72684c5c920ce8af1da54a2268047342589" build

RUN cd /home/build

# Run as the following user
#USER daemon

# Say hello when the container is launched
#ENTRYPOINT echo "Whale You Be My Container?"
#ENTRYPOINT ["echo", "Whale You Be My Container?"]
#ENTRYPOINT ["wc", "-l"]
#ENTRYPOINT ["memcached", "-u", "daemon"]
#ENTRYPOINT ["memcached"]
#ENTRYPOINT ["echo", "Welcome to easy-build!"]
ENTRYPOINT ["/bin/bash"]

# Expose memcached port
#EXPOSE 11211

# EOF
