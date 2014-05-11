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
