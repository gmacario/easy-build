# ===========================================================================================
# Project: https://github.com/gmacario/easy-build
#
# Subproject: build-yocto-genivi
#
# Description: Dockerfile for building the Yocto GENIVI Baseline
# and the GENIVI Demo Platform either interactively or as a GoCD agent
#
# References:
#	- http://projects.genivi.org/GENIVI_Baselines/meta-ivi/home
# - https://at.projects.genivi.org/jira/browse/TOOL-21
#
# Usage Examples
# --------------
#
# Build the Docker image
# $ docker build -t test/build-yocto-genivi build-yocto-genivi
#
# Create a development environment to interactively build YGB and GDP
# $ docker run -ti test/build-yocto-genivi
#
# Mount a host volume to store build results
# $ docker run -ti --volume $PWD:/home/build test/build-yocto-genivi /usr/local/bin/clone-and-build-gdp.sh
#
# === UNTESTED CONFIGURATIONS ===
#
# --- Run the Docker image as a GoCD agent ---
# $ docker run -d test/build-yocto-genivi TODO
#
# TODO Build GDP non-interactively
#
# --- Attach to a demonized development environment via ssh ---
# TODO: STILL CANNOT CONNECT
# $ mkdir -p ./.ssh/ && chmod 700 ./.ssh && cat ~/.ssh/id_rsa.pub | tee -a ./.ssh/authorized_keys && chmod 640 ./.ssh/authorized_keys
# $ docker run -ti -u root -p 50022:22 --volume $PWD:/home/build test/build-yocto-genivi /bin/bash
#   service ssh restart
#
# From another terminal
# $ ssh -p 50022 build@localhost
# ===========================================================================================

# TODO: FROM gmacario/build-yocto
FROM gocd/gocd-agent:15.3.1

MAINTAINER Gianpaolo Macario <gianpaolo_macario@mentor.com>

# Make sure the package repository is up to date
RUN apt-get update && apt-get -y upgrade

# Install some packages I cannot stay without...
RUN apt-get install -y dos2unix git mc openssh-server screen tig

# Install the following utilities (required by poky)
RUN apt-get install -y curl make gcc g++ diffstat texinfo gawk chrpath wget libsdl1.2-dev

# Make sure the directory exists, otherwise sshd will not start
RUN mkdir -p /var/run/sshd

# Create non-root user that will perform the build of the images
RUN id build >/dev/null || useradd --create-home --shell /bin/bash build

#RUN mkdir -p /home/build/shared
#COPY configure_build.sh /home/build/
#RUN chown -R build.build /home/build
#RUN cd /home/build

COPY clone-and-build-gdp.sh /usr/local/bin
RUN dos2unix /usr/local/bin/*.sh && chmod 755 /usr/local/bin/*.sh

# Expose sshd port
EXPOSE 22

USER build
WORKDIR /home/build
CMD ["/bin/bash"]

# EOF
