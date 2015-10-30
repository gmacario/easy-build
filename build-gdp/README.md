## Setup

To build this docker image, you will need your Docker server configured to support base filesystem images larger than 10GB. The documentation suggests that starting docker with:

    docker -d -s=devicemapper --storage-opt dm.basesize=30G

should suffice.

## Building locally

    docker build -t genivi-demo-platform .

### Running docker manually

This command will create and start a new container

    docker run -it genivi-demo-platform

