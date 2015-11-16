# Dockerfile for creating an easy-build baseimage implementing a Jenkins slave node
# See https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds

FROM gmacario/easy-build:latest

MAINTAINER Gianpaolo Macario <gmacario@gmail.com>

# Add prerequisites to run Jenkins slave using JNLP
# Adapted from https://github.com/jenkinsci/docker-jnlp-slave

ENV HOME /home/jenkins
RUN useradd -c "Jenkins user" -d $HOME -m jenkins

COPY jenkins-slave /usr/local/bin/jenkins-slave

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar \
    http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.52/remoting-2.52.jar && \
    chmod 755 /usr/share/jenkins && \
    chmod 644 /usr/share/jenkins/slave.jar && \
    chmod 755 /usr/local/bin/jenkins-slave

# Install OpenJDK (required by Jenkins)
# TODO: Maybe jre is just enaough...
RUN apt-get update && apt-get install -y openjdk-7-jdk

# Define container entry point
USER jenkins
ENTRYPOINT ["/bin/bash"]

# EOF
