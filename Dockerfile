# ===========================================================================================
# Projetc: easy-build
#
# Description: Base Docker image for building embedded distros
# ===========================================================================================

FROM ubuntu:18.04

# Make sure the package repository is up to date, then install required packages
RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y git mc tig tree

# Create non-root user that will perform the build of the images
RUN useradd --shell /bin/bash build && mkdir -p /home/build && chown -R build /home/build

# Leave derived dockerfiles to download source repositories
# RUN cd /home/build

# Run as the following user
# USER daemon

ENTRYPOINT ["/bin/bash"]

# EOF
