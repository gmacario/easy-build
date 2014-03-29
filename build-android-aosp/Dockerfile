# ===========================================================================================
# Dockerfile for building Android Open Source Project
# 
# References:
#	http://projects.genivi.org/GENIVI_Baselines/meta-ivi/home
#	https://www.docker.io/learn/dockerfile/level1/
#	https://www.docker.io/learn/dockerfile/level2/
# ===========================================================================================

FROM gmacario/easy-build
#FROM ubuntu

MAINTAINER Gianpaolo Macario, gmacario@gmail.com

# Make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Install essential packages
RUN apt-get install -y git tig
RUN apt-get install -y mc

# Install required packages
# See https://source.android.com/source/building.html
RUN apt-get install -y python
RUN apt-get install -y make
#RUN apt-get install -y openjdk-7-jdk

# Create non-root user that will perform the build of the images
#RUN useradd --shell /bin/bash build
#RUN mkdir -p /home/build
#RUN chown -R build /home/build

# See https://source.android.com/source/initializing.html

#RUN update-alternatives --config java
#RUN update-alternatives --config javac

RUN apt-get install -y git gnupg flex bison gperf build-essential \
  zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
  libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
  libgl1-mesa-dev g++-multilib mingw32 tofrodos \
  python-markdown libxml2-utils xsltproc zlib1g-dev:i386
RUN ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 \
	/usr/lib/i386-linux-gnu/libGL.so

# Downloading the Source
# See https://source.android.com/source/downloading.html

# Initializing a Repo client
RUN su -c "cd && repo init -u https://android.googlesource.com/platform/manifest \
	-b androuid-4.0.1_r1" build
RUN su -c "cd && repo sync" build

RUN cd /home/build

# Run as the following user
#USER build

# Say hello when the container is launched
ENTRYPOINT ["/bin/bash"]

# Expose memcached port
#EXPOSE 11211

# EOF
