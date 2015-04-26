#!/bin/sh

# Configure script for building the GENIVI Yocto baseline
# See https://github.com/gmacario/easy-build/tree/master/build-yocto-genivi

if [ "${YPSOURCES}" = "" ]; then
    export YPSOURCES=${HOME}/shared/sources
    echo "WARNING: Environment variable YPSOURCES was not defined - defaulting to ${YPSOURCES}"
fi
mkdir -p ${YPSOURCES}

echo "NOTE: Updating YP source repositories"
cd ${YPSOURCES}
[ ! -e meta-genivi-demo ]  && git clone git://git.projects.genivi.org/meta-genivi-demo
[ ! -e meta-ivi ]          && git clone git://git.yoctoproject.org/meta-ivi
[ ! -e poky ]              && git clone git://git.yoctoproject.org/poky
[ ! -e meta-qt5 ]          && git clone https://github.com/meta-qt5/meta-qt5.git
[ ! -e meta-openembedded ] && git clone git://git.openembedded.org/meta-openembedded
# Renesas BSP
[ ! -e meta-renesas ]      && git clone https://github.com/slawr/meta-renesas.git

# (TESTING) Known SHA for Yocto GENIVI Demo Platform for Renesas Porter Board
cd ${YPSOURCES}/meta-genivi-demo	&& git fetch --all && git checkout master
cd ${YPSOURCES}/meta-ivi 		&& git fetch --all && git checkout 7.0
cd ${YPSOURCES}/poky     		&& git fetch --all && git checkout dizzy
cd ${YPSOURCES}/meta-qt5  		&& git fetch --all && git checkout dizzy
cd ${YPSOURCES}/meta-openembedded  	&& git fetch --all && git checkout dizzy
cd ${YPSOURCES}/meta-renesas	  	&& git fetch --all && git checkout genivi-7.0-bsp-1.8.0

# (TESTING) SHA for Yocto GENIVI Baseline master branch
# See http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md
#cd ${YPSOURCES}/meta-ivi 		&& git fetch --all && git checkout master
#cd ${YPSOURCES}/poky     		&& git fetch --all && git checkout dizzy
#cd ${YPSOURCES}/meta-openembedded	&& git fetch --all && git checkout dizzy

# Known SHA for Yocto GENIVI Baseline 8.0 (J-0.1)
# See http://lists.genivi.org/pipermail/genivi-meta-ivi/2015-March/000487.html
# and http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=7.0.3
#cd ${YPSOURCES}/meta-ivi 		&& git fetch --all && git checkout 8.0
#cd ${YPSOURCES}/poky     		&& git fetch --all && git checkout 6dd21a9f152a93e2df1178d7a5bd903d7edcf4be
#cd ${YPSOURCES}/meta-openembedded  	&& git fetch --all && git checkout 853dcfa0d618dc26bd27b3a1b49494b98d6eee97

# Known SHA for Yocto GENIVI Baseline 7.0.3 (I-1.2)
# See http://lists.genivi.org/pipermail/genivi-meta-ivi/2015-January/000453.html
# and http://git.yoctoproject.org/cgit/cgit.cgi/meta-ivi/tree/README.md?id=7.0.3
#cd ${YPSOURCES}/meta-ivi 		&& git fetch --all && git checkout 7.0.3
#cd ${YPSOURCES}/poky     		&& git fetch --all && git checkout df87cb27efeaea1455f20692f9f1397c6fcab254
#cd ${YPSOURCES}/meta-openembedded  	&& git fetch --all && git checkout 9efaed99125b1c4324663d9a1b2d3319c74e7278

if [ "${BUILDDIR}" = "" ]; then
    echo "ERROR: Environment variable BUILDDIR is not defined"
    echo "Please execute: \`cd ~/shared && source ${YPSOURCES}/poky/oe-init-build-env [builddir]\`"
    echo "then execute again: \`$0\`"
    exit 1
fi

cd ${BUILDDIR}

# TODO: Implement smart algorithm for conffile
#
# 1. File x.conf does not exist, file x.conf.ORIG does not exist: Tell user to run oe-create-devenv again
# 2. File x.conf exists, file x.conf.ORIG exists: Do nothing - assuming the script already run
# 3. File x.conf exists, file x.conf.ORIG does not exist: Save file x.conf as x.conf.ORIG then patch it
# 4. File x.conf does not exist, file x.conf.ORIG exists: Create patched x.conf starting from x.conf.ORIG
#
#if [ ! -e ${BUILDDIR}/conf/bblayers.conf ]; then
#    if [ ! -e ${BUILDDIR}/conf/bblayers.conf.ORIG ]; then
#        echo "ERROR: Cannot patch bblayers.conf"
#    fi 
#else
#    if [ -e ${BUILDDIR}/conf/bblayers.conf.ORIG ]; then
#        echo "WARNING: ${BUILDDIR}/conf/bblayers.conf.ORIG file exists - Skip patching bblayers.conf"
#    else
#        cp ${BUILDDIR}/conf/bblayers.conf ${BUILDDIR}/conf/bblayers.conf.ORIG
#        # Patch
#    fi
#fi

if [ -e ${BUILDDIR}/conf/bblayers.conf.ORIG ]; then
    echo "WARNING: ${BUILDDIR}/conf/bblayers.conf.ORIG file exists - Skip patching bblayers.conf"
else
    cp ${BUILDDIR}/conf/bblayers.conf ${BUILDDIR}/conf/bblayers.conf.ORIG
    echo "INFO: Adjusting ${BUILDDIR}/conf/bblayers.conf"
cat <<__END__ >>${BUILDDIR}/conf/bblayers.conf
# Extra layers for the Yocto GENIVI Baseline
BBLAYERS += " \\
  ${YPSOURCES}/meta-ivi/meta-ivi \\
  ${YPSOURCES}/meta-ivi/meta-ivi-bsp \\
  ${YPSOURCES}/meta-openembedded/meta-oe \\
  "
__END__

cat <<__END__ >>${BUILDDIR}/conf/bblayers.conf
# Extra layers for the Yocto GENIVI Demo Platform
BBLAYERS += " \\
  ${YPSOURCES}/meta-genivi-demo \\
  ${YPSOURCES}/meta-qt5 \\
  ${YPSOURCES}/meta-openembedded/meta-ruby \\
  ${YPSOURCES}/meta-renesas \\
  "
__END__
fi # Patch conf/bblayers.conf

if [ -e ${BUILDDIR}/conf/local.conf.ORIG ]; then
    echo "WARNING: ${BUILDDIR}/conf/local.conf.ORIG file exists - Skip patching local.conf"
else
    cp ${BUILDDIR}/conf/local.conf ${BUILDDIR}/conf/local.conf.ORIG
    echo "INFO: Adjusting ${BUILDDIR}/conf/local.conf"
cat <<__END__ >>${BUILDDIR}/conf/local.conf

# Override config options in conf/local.conf
#
#BB_NUMBER_THREADS = "4"
#PARALLEL_MAKE = "-j 4"
#
DL_DIR ?= "${BUILDDIR}/../downloads"
#
DISTRO = "poky-ivi-systemd"
#DISTRO_FEATURES_append = " opengl"
#DISTRO_FEATURES_append = " pam"
#DISTRO_FEATURES_append = " systemd"
#DISTRO_FEATURES_append = " x11"
#
# Uncomment for GENIVI baseline (for GDP should leave it commented out)
#INCOMPATIBLE_LICENSE = "GPLv3"
#
#MACHINE ?= "vexpressa9"
#MACHINE ?= "qemux86"
MACHINE ?= "qemux86-64"
#
# Additional machines supported by GDP
#MACHINE ?= "porter"
#
# When building for porter, add the following to your local.conf:
#
#MACHINE = "porter"
#LICENSE_FLAGS_WHITELIST = "commercial"
#SDKIMAGE_FEATURES_append = " staticdev-pkgs"
#MACHINE_FEATURES_append = " sgx"
#MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2"
#PREFERRED_PROVIDER_virtual/libgles1 = ""
#PREFERRED_PROVIDER_virtual/libgles2 = "gles-user-module"
#PREFERRED_PROVIDER_virtual/egl = "libegl"
#PREFERRED_PROVIDER_virtual/libgl = ""
#PREFERRED_PROVIDER_virtual/mesa = ""
#PREFERRED_PROVIDER_libgbm = "libgbm"
#PREFERRED_PROVIDER_libgbm-dev = "libgbm"
#
#PREFERRED_VERSION_linux-yocto_vexpressa9 = "3.10.11"
__END__
fi # Patch conf/local.conf

echo "INFO: You may now run: \`time bitbake -k genivi-demo-platform\`"

# === EOF ===
