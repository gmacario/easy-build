# ===========================================================================================
# Dockerfile for building the Yocto GENIVI Baseline
# 
# References:
#	http://projects.genivi.org/GENIVI_Baselines/meta-ivi/home
# ===========================================================================================

#FROM ubuntu
FROM gmacario/easy-build

MAINTAINER Gianpaolo Macario, gmacario@gmail.com

# Make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Install packages we cannot leave without...
RUN apt-get install -y git tig
RUN apt-get install -y mc

# Install the following utilities (required by poky)
RUN apt-get install -y make gcc g++ diffstat texinfo gawk chrpath wget

## Create non-root user that will perform the build of the images
#RUN useradd --shell /bin/bash build
#RUN mkdir -p /home/build
#RUN chown -R build /home/build

# Clone meta-ivi and poky repos
RUN su -c "mkdir -p ~/genivi-baseline" build
RUN su -c "cd ~/genivi-baseline \
	&& git clone git://git.yoctoproject.org/poky \
	&& cd poky \
	&& git checkout 53d2563ff13fcec74d4250bef5419e36169e55cc" build
RUN su -c "cd ~/genivi-baseline \
	&& git clone git://git.yoctoproject.org/meta-ivi \
	&& cd meta-ivi \
	&& git checkout 5.0" build

#RUN cd /home/build

# Run as the following user
#USER daemon

# Define container entry point
ENTRYPOINT ["/bin/bash"]

# Expose memcached port
#EXPOSE 11211

# EOF
