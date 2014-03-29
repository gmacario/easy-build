easy-build
==========

Perform an easy build of the GENIVI Yocto Baseline using Docker

System Requirements
-------------------

* Docker 0.9.1 or later
* A fast Internet connection

Building
--------

```
docker build -t mybuild github.com/gmacario/easy-build
```

Running locally built image
---------------------------

Option 1:

```
docker run -i -t mybuild
sudo -i build
# TODO
```

Option 2:

```
docker run -i -t mybuild su build
# TODO
```

Running pre-built image
-----------------------

```
docker run -i -t gmacario/easy-build su build
# TODO
```
