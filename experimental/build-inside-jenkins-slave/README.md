build-inside-jenkins-slave
==========================

Building the Docker image

    $ docker build -t gmacario/build-inside-jenkins-slave .

Running the slave as a Docker container

    $ docker run [docker-run-opts] \
      gmacario/build-inside-jenkins-slave jenkins-slave \
      -url $JENKINS_SERVER_URL \
      $SECRET $SLAVE_NAME

Example

    $ docker run -d --name my-slave-01 -u jenkins \
      gmacario/build-inside-jenkins-slave jenkins-slave \
      -url http://mv-linux-powerhorse.solarma.it:9080/ \
      mysecret my-slave-01

<!-- EOF -->
