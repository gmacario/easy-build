build-in-jenkins-slave
======================

This subproject of [easy-build](https://github.com/gmacario/easy-build)
extends the easy-build base image to implement a [Jenkins](http://jenkins-ci.org/) slave node.

See <https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds> to learn
about the architecture of Jenkins distributed builds.

### Building the Docker image

    $ docker build -t gmacario/build-in-jenkins-slave .

### Running the slave as a Docker container

    $ docker run [docker-run-opts] \
      gmacario/build-in-jenkins-slave jenkins-slave \
      -url ${JENKINS_SERVER_URL} \
      ${SECRET} \
      ${SLAVE_NAME}

Example:

    $ JENKINS_SERVER_URL=http://mv-linux-powerhorse.solarma.it:9080/ && \
      SECRET=f10b43a9aa63864188dc627243fd2a660926e1f7745322984e6b3aa2c5707a5f && \
      SLAVE_NAME=my-slave-11 && \
      docker run -d --name=${SLAVE_NAME} -u jenkins \
      gmacario/build-in-jenkins-slave jenkins-slave \
      -url ${JENKINS_SERVER_URL} \
      ${SECRET} \
      ${SLAVE_NAME}

<!-- EOF -->
