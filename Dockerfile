# ===========================================================================================
# Projetc: easy-build
#
# Description: Base Docker imaeg for building embedded distros
# ===========================================================================================

FROM gmacario/baseimage-ssh:latest
MAINTAINER Gianpaolo Macario <gmacario@gmail.com>

# Make sure the package repository is up to date
RUN apt-get update && apt-get -y upgrade

# Install required packages
RUN apt-get install -y git mc tig

# Create non-root user that will perform the build of the images
RUN useradd --shell /bin/bash build && mkdir -p /home/build && chown -R build /home/build

# Leave derived dockerfiles to download source repositories
# RUN cd /home/build

# Run as the following user
# USER daemon

ENTRYPOINT ["/bin/bash"]

# EOF
