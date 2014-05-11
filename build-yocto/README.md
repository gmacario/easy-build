build-yocto
===========

Building Docker image
---------------------

    docker build -t gmacario/build-yocto .

Running Docker image
--------------------

    docker run -t -i gmacario/build-yocto

Once the container is running

    cd /opt/yocto/poky
    git checkout -b daisy origin/daisy

Create build environment

    cd /work
    source /opt/yocto/poky/oe-init-build-env build-test01

Start the build

    bitbake -k core-image-sato
    
### Using the "wic" tool

#### Show program version

Yocto 1.6 provides version 0.1.0
```
root@eb4b9143265d:/work/build-test01# wic --version
wic version 0.1.0
root@eb4b9143265d:/work/build-test01#
```

#### Show program help
```
root@eb4b9143265d:/work/build-test01# wic --help
Usage:

 Create a customized OpenEmbedded image

 usage: wic [--version] [--help] COMMAND [ARGS]

 Current 'wic' commands are:
    create            Create a new OpenEmbedded image
    list              List available values for options and image properties

 See 'wic help COMMAND' for more information on a specific command.


Options:
  --version   show program's version number and exit
  -h, --help  show this help message and exit
root@eb4b9143265d:/work/build-test01#
```

#### List available OpenEmbedded image properties
```
root@eb4b9143265d:/work/build-test01# wic list images
  directdisk            Create a 'pcbios' direct disk image
  mkefidisk             Create an EFI disk image
root@eb4b9143265d:/work/build-test01#
```

TODO

Known issues and workarounds
----------------------------

### bitbake complains if run as root

```
root@eb4b9143265d:/work/build-test01# bitbake -k core-image-sato
ERROR:  OE-core's config sanity checker detected a potential misconfiguration.
    Either fix the cause of this error or at your own risk disable the checker (see sanity.conf).
    Following is the list of potential problems / advisories:

    Do not use Bitbake as root.
ERROR: Execution of event handler 'check_sanity_eventhandler' failed
ERROR: Command execution failed: Exited with 1

Summary: There were 3 ERROR messages shown, returning a non-zero exit code.
root@eb4b9143265d:/work/build-test01#
```

Workaround:

    $ touch conf/sanity.conf

EOF
