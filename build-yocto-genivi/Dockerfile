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

# TODO: FROM gmacario/build-yocto
FROM gocd/gocd-agent:16.1.0

MAINTAINER Gianpaolo Macario <gianpaolo_macario@mentor.com>

# Make sure the package repository is up to date
RUN apt-get update && apt-get -y upgrade

# Install some packages I cannot live without...
RUN apt-get install -y dos2unix git mc openssh-server screen tig

# Install the following utilities (required by poky)
RUN apt-get install -y curl make gcc g++ diffstat texinfo gawk chrpath wget libsdl1.2-dev

# Extra packages required for building GDP - See https://github.com/gmacario/easy-build/issues/215
RUN apt-get install -y git-svn

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
