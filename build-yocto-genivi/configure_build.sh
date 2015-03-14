#!/bin/sh

# Conflgure script for building GENIVI Yocto baseline
# See https://github.com/gmacario/easy-build/tree/master/build-yocto-genivi

# (TESTING) SHA for Yocto GENIVI Baseline master branch
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md
#cd $GENIVI/meta-ivi 		&& git fetch --all && git checkout master
#cd $GENIVI/poky     		&& git fetch --all && git checkout dizzy
#cd $GENIVI/meta-openembedded	&& git fetch --all && git checkout dizzy

# Known SHA for Yocto GENIVI Baseline 7.0.3 (I-1.2)
# See http://lists.genivi.org/pipermail/genivi-meta-ivi/2015-January/000453.html
# and http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=7.0.3
cd $GENIVI/meta-ivi 		&& git fetch --all && git checkout 7.0.3
cd $GENIVI/poky     		&& git fetch --all && git checkout df87cb27efeaea1455f20692f9f1397c6fcab254
cd $GENIVI/meta-openembedded  	&& git fetch --all && git checkout 9efaed99125b1c4324663d9a1b2d3319c74e7278

# Known SHA for Yocto GENIVI Baseline 7.0.2 (I-1.1)
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=7.0.2
#cd $GENIVI/meta-ivi 		&& git fetch --all && git checkout 7.0.2
#cd $GENIVI/poky     		&& git fetch --all && git checkout df87cb27efeaea1455f20692f9f1397c6fcab254
#cd $GENIVI/meta-openembedded  	&& git fetch --all && git checkout 9efaed99125b1c4324663d9a1b2d3319c74e7278

# Known SHA for Yocto GENIVI Baseline 7.0.1
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=7.0.1
#cd $GENIVI/meta-ivi 		&& git checkout 7.0.1
#cd $GENIVI/poky     		&& git checkout 39ca8b429b6244e9649e7303cbb240adf007bf22
#cd $GENIVI/meta-openembedded  	&& git checkout 0d01e1b72333f49c29d1a27ad844c4cd9f90341c

# Known SHA for Yocto GENIVI Baseline 7.0.0
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=7.0.0
#cd $GENIVI/meta-ivi && git checkout 7.0.0
#cd $GENIVI/poky     && git checkout f3d08464ef0e8ee11fe9d59857f4be314cd64580

# Known SHA for Yocto GENIVI Baseline 6.0.2
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=6.0.2
#cd $GENIVI/meta-ivi && git checkout 6.0.2
#cd $GENIVI/poky     && git checkout 8e05d5e3fe04face623c4f9fb08b12f13c22edab

# Known SHA for Yocto GENIVI Baseline 6.0.1
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=6.0.1
#cd $GENIVI/meta-ivi && git checkout 6.0.1
#cd $GENIVI/poky     && git checkout bf8dcb43432004328162ddad3c8b38eaab6ab5ce

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
  $GENIVI/meta-ivi/meta-ivi \
  $GENIVI/meta-ivi/meta-ivi-bsp \
  $GENIVI/meta-openembedded/meta-oe \
  "
__END__

cp $TOPDIR/conf/local.conf $TOPDIR/conf/local.conf.ORIG
cat <<__END__ >>$TOPDIR/conf/local.conf
# Override config options in conf/local.conf
#
#BB_NUMBER_THREADS = "4"
#PARALLEL_MAKE = "-j 4"
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
