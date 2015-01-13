build-openwrt
=============

This subproject of [easy-build](https://github.com/gmacario/easy-build) provides
a quick and easy way for creating an [OpenWrt](https://openwrt.org/) image.

Building the Docker image
-------------------------

```
$ cd easy-build/openwrt
```

Copy your local patches, custom scripts, etc to `easy-build/openwrt/build.local`,
then invoke the `build.sh` script:

```
$ ./build.sh
```

Running the container
---------------------

You may use the `run.sh` script which will restart the container if it exists,
otherwise it will create and run a new one using the corresponding Docker image:

```
$ ./run.sh
```

When logged as root@container

```
root@029a53d8cd99:/# su - build
```

then proceed as explained in the OpenWrt documentation.

For a complete example you may refer to the following pages

* https://github.com/gmacario/kingston-mlwg2-hack/wiki/Rebuilding-OpenWrt-for-MLWG2

<!-- EOF -->
