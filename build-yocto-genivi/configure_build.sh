#!/bin/sh

# Conflgure script for building GENIVI Yocto baseline
# See https://github.com/gmacario/easy-build/tree/master/build-yocto-genivi

# (TESTING) SHA for Yocto GENIVI Baseline master branch
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md
#cd $GENIVI/meta-ivi && git checkout master
#cd $GENIVI/poky     && git checkout master

# Known SHA for Yocto GENIVI Baseline 6.0.1
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=6.0.1
cd $GENIVI/meta-ivi && git checkout 6.0.1
cd $GENIVI/poky     && git checkout bf8dcb43432004328162ddad3c8b38eaab6ab5ce

# Known SHA for Yocto GENIVI Baseline 6.0.0
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=6.0.0
#cd $GENIVI/meta-ivi && git checkout 6.0.0
#cd $GENIVI/poky     && git checkout bf8dcb43432004328162ddad3c8b38eaab6ab5ce

# Known SHA for Yocto GENIVI Baseline 5.0.2
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=5.0.2
#cd $GENIVI/meta-ivi && git checkout 5.0.2
#cd $GENIVI/poky     && git checkout 53d2563ff13fcec74d4250bef5419e36169e55cc

# Known SHA for Yocto GENIVI Baseline 5.0.1
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=5.0.1
#cd $GENIVI/meta-ivi && git checkout 5.0.1
#cd $GENIVI/poky     && git checkout 53d2563ff13fcec74d4250bef5419e36169e55cc

# Known SHA for Yocto GENIVI Baseline 5.0.0
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=5.0.0
#cd $GENIVI/meta-ivi && git checkout 5.0.0
#cd $GENIVI/poky     && git checkout 56f39bcf2237c11508d82238b6292e4bfbfed764

cd $TOPDIR

cp $TOPDIR/conf/bblayers.conf $TOPDIR/conf/bblayers.conf.ORIG
cat <<__END__ >>$TOPDIR/conf/bblayers.conf
BBLAYERS += " \
  $GENIVI/meta-ivi \
  $GENIVI/meta-ivi/meta-ivi-bsp \
  "
__END__

cp $TOPDIR/conf/local.conf $TOPDIR/conf/local.conf.ORIG
cat <<__END__ >>$TOPDIR/conf/local.conf
# Override config options in conf/local.conf
BB_NUMBER_THREADS = "4"
PARALLEL_MAKE = "-j 4"
#
DISTRO = "poky-ivi-systemd"
#DISTRO_FEATURES_append = " opengl"
#DISTRO_FEATURES_append = " pam"
#DISTRO_FEATURES_append = " systemd"
#DISTRO_FEATURES_append = " x11"
#
#MACHINE ?= "vexpressa9"
MACHINE ?= "qemux86"
#MACHINE ?= "qemux86-64"
#
#PREFERRED_VERSION_linux-yocto_vexpressa9 = "3.10.11"
#
INCOMPATIBLE_LICENSE = "GPLv3"
__END__

# === EOF ===
