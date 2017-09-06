FROM ubuntu:14.04

RUN apt-get update && apt-get -y upgrade

# Install the following utilities (required by poky)
RUN apt-get install -y build-essential chrpath curl diffstat gcc-multilib gawk git-core libsdl1.2-dev texinfo unzip wget xterm

# Additional host packages required by poky/scripts/wic
RUN apt-get install -y bzip2 dosfstools mtools parted syslinux tree

# Add "repo" tool (used by many Yocto-based projects)
RUN curl http://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo

# Create user "jenkins"
RUN id jenkins 2>/dev/null || useradd --uid 1000 --create-home jenkins

# Create a non-root user that will perform the actual build
RUN id build 2>/dev/null || useradd --uid 30000 --create-home build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

# Fix error "Please use a locale setting which supports utf-8."
# See https://wiki.yoctoproject.org/wiki/TipsAndTricks/ResolvingLocaleIssues
RUN apt -y install locales && \
  dpkg-reconfigure locales && \
  locale-gen en_US.UTF-8 && \
  update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

RUN echo " \n\
export LC_ALL=en_US.UTF-8 \n\
export LANG=en_US.UTF-8 \n\
export LANGUAGE=en_US.UTF-8 \n\
" >> /home/build/.profile

USER build
WORKDIR /home/build
CMD "/bin/bash"

# EOF
