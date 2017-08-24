# ===========================================================================================
# Project: https://github.com/gmacario/easy-build
#
# Subproject: build-yocto-genivi
#
# Description: Dockerfile for building the Yocto GENIVI Baseline
# and the GENIVI Demo Platform either interactively or as a GoCD agent
#
# References:
#   - http://projects.genivi.org/GENIVI_Baselines/meta-ivi/home
#   - https://at.projects.genivi.org/jira/browse/TOOL-21
#
# === SOME COMMON USAGE SCENARIOS ===
#
# --- Build the Docker image ---
# $ docker build -t test/build-yocto-genivi build-yocto-genivi
#
# --- Create a development environment for building YGB and GDP ---
# $ docker run -ti test/build-yocto-genivi
# Then execute /usr/local/bin/clone-and-build-gdp.sh or consult the GENIVI wiki
#
# --- Build GDP storing build results on a separate volume ---
# $ docker run -ti --volume $PWD:/home/build test/build-yocto-genivi /usr/local/bin/clone-and-build-gdp.sh
#
# --- Connect to a running development environment using SSH ---
# $ mkdir /tmp/shared && cd /tmp/shared
# $ mkdir -p .ssh && chmod 700 .ssh
# $ cat ~/.ssh/id_rsa.pub | tee -a .ssh/authorized_keys && chmod 640 .ssh/authorized_keys
# $ docker run -ti -u root -p 5022:22 --volume $PWD:/home/build test/build-yocto-genivi
#   usermod -p verysecret build && service ssh restart
#   ...
#
# From another terminal on the same host
# $ ssh -p 5022 build@localhost

# === OTHER SCENARIOS (WORK-IN-PROGRESS) ===
#
# --- Run the Docker image as a GoCD agent ---
# $ docker run -d test/build-yocto-genivi TODO
# ===========================================================================================

FROM gocd/gocd-agent-ubuntu-14.04:v17.8.0

MAINTAINER Gianpaolo Macario <gianpaolo_macario@mentor.com>

# Make sure the package repository is up to date
RUN apt-get update && apt-get -y dist-upgrade

# Install some packages I cannot live without...
RUN apt-get -y install dos2unix git mc openssh-server screen tig tree

# Install the following utilities (required by poky)
RUN apt-get -y install curl make gcc g++ diffstat texinfo gawk chrpath wget libsdl1.2-dev

# Install extra packages (required for building GDP)
RUN apt-get -y install gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat libsdl1.2-dev xterm git-svn

# Make sure tool add-apt-repository is installed
RUN apt-get -y install software-properties-common

# Update to OpenJDK-8 (baseimage gocd/gocd-agent:16.1.0 has openjdk-7-jre-headless)
# See easy-build/issues/241
RUN add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get -y install openjdk-8-jre-headless && \
    apt-get -y remove --purge openjdk-7-jre-headless
    
# Make sure the directory exists, otherwise sshd will not start
RUN mkdir -p /var/run/sshd

# Create non-root user that will perform the build of the images
RUN id build >/dev/null || useradd --create-home --shell /bin/bash build

#RUN mkdir -p /home/build/shared
#COPY configure_build.sh /home/build/
#RUN chown -R build.build /home/build
#RUN cd /home/build

RUN mkdir -p /usr/local/bin
COPY clone-and-build-gdp.sh /usr/local/bin/
COPY run-gocd-agent.sh /usr/local/bin/
RUN dos2unix /usr/local/bin/*.sh && chmod 755 /usr/local/bin/*.sh

# Expose sshd port
EXPOSE 22

USER build
WORKDIR /home/build
CMD ["/bin/bash"]

# EOF
