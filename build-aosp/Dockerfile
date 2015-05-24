# ===========================================================================================
# Dockerfile for building Android Open Source Project
# 
# References:
#	http://source.android.com/source/index.html
# ===========================================================================================

FROM gmacario/easy-build
#FROM ubuntu

MAINTAINER Gianpaolo Macario <gmacario@gmail.com>

# See https://github.com/docker/docker/issues/4032
ENV DEBIAN_FRONTEND noninteractive

# Make sure the package repository is up to date
RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN dpkg --add-architecture i386
RUN apt-get -qq update

# Install essential packages
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y tig
RUN apt-get install -y mc
RUN apt-get install -y rsync
RUN apt-get install -y screen

# See https://source.android.com/source/initializing.html
#
# The master branch of Android in the Android Open Source Project (AOSP)
# requires Java 7. On Ubuntu, use OpenJDK.
# To develop older versions of Android, download and install
# the corresponding version of the Java JDK (not OpenJDK):
# * Java 6: for Gingerbread through KitKat
# * Java 5: for Cupcake through Froyo
#
#RUN apt-get install -y openjdk-7-jdk
#
#RUN update-alternatives --config java
#RUN update-alternatives --config javac
#
# Installing required packages (Ubuntu 14.04)
#
RUN apt-get install -y bc bison build-essential ccache flex
RUN apt-get install -y g++-multilib gcc-multilib git gperf
RUN apt-get install -y lib32stdc++6 lib32z1 lib32z1-dev liblzo2-dev
RUN apt-get install -y libxml2-utils lzop make python
RUN apt-get install -y u-boot-tools uuid-dev zip zlib1g-dev:i386

#RUN apt-get install -y git gnupg flex bison gperf build-essential \
#  zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
#  libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
#  libgl1-mesa-dev g++-multilib mingw32 tofrodos \
#  python-markdown libxml2-utils xsltproc zlib1g-dev:i386
#RUN ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 \
#	/usr/lib/i386-linux-gnu/libGL.so

RUN apt-get -qqy dist-upgrade

# Optional: Install apt-file to find which package provides a given file
#RUN apt-get -y install apt-file
#RUN apt-file update

# Create non-root user that will perform the build of the images
#RUN useradd --shell /bin/bash build
#RUN mkdir -p /home/build
#RUN chown -R build /home/build

# Downloading the Source
# See https://source.android.com/source/downloading.html

RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo

# Initializing a Repo client
#RUN su -c "cd && repo init -u https://android.googlesource.com/platform/manifest \
#	-b android-4.0.1_r1" build
#RUN su -c "cd && repo sync" build

RUN cd /home/build

# Run as the following user
#USER build

# Say hello when the container is launched
ENTRYPOINT ["/bin/bash"]

# Expose memcached port
#EXPOSE 11211

# EOF
