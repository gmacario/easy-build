#!/bin/bash

echo "Setup script to initialize a yocto build project for Renesas R-Car H3 Platform"
echo "Source: http://elinux.org/R-Car/Boards/Yocto-Gen3#Running_Yocto_image"
echo
echo "Warning: This is going to take a long time to download and build the necessary packages."

MIN_SPACE=40 # GB
FREE_SPACE=$(df --output=avail / | tail -1 | awk '{printf("%d\n", ($1/(1024*1024)))}')

if [ $FREE_SPACE -lt $MIN_SPACE ]; then
	echo "Error: Not enough disk space, minimum requirement $MIN_SPACE GB"
	echo "Exiting ..."
	exit 1;
fi

SETUP_DIR="$HOME/yocto"
# Get source directory of the script
# https://stackoverflow.com/a/246128/2247646
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
POKY_DIR="$SETUP_DIR/poky"
POKY_CONF_DIR="$POKY_DIR/build/conf"
M_RENESAS_DIR="$POKY_DIR/meta-renesas"
M_LINARO_DIR="$POKY_DIR/meta-linaro"
M_OPENEMBEDDED_DIR="$POKY_DIR/meta-openembedded"

mkdir -p "$SETUP_DIR" || { echo "Error: mkdir for $SETUP_DIR failed, exiting ..."; exit 1; }

cd "$SETUP_DIR" || { echo "Error: cd-ing into $SETUP_DIR failed, exiting ..."; exit 1; }

echo "Cloning poky repo"
git clone https://git.yoctoproject.org/git/poky $POKY_DIR || { echo "Error: Cloning poky repo failed, exiting ..."; exit 1; }

cd "$POKY_DIR" || { echo "Error: cd-ing into $POKY_DIR failed, exiting ..."; exit 1; }
git checkout -b krogoth remotes/origin/krogoth

echo "Cloning meta-renesas repo"
git clone https://github.com/renesas-rcar/meta-renesas.git $M_RENESAS_DIR || { echo "Error: Cloning meta-renesas repo failed, exiting ..."; exit 1; }

cd "$M_RENESAS_DIR" || { echo "Error: cd-ing into $M_RENESAS_DIR failed, exiting ..."; exit 1; }
git checkout krogoth || git checkout -b krogoth remotes/origin/krogoth

echo "Cloning meta-linaro repo"
git clone https://git.linaro.org/openembedded/meta-linaro.git $M_LINARO_DIR || { echo "Error: Cloning meta-linaro repo failed, exiting ..."; exit 1; }
cd "$M_LINARO_DIR" || { echo "Error: cd-ing into $M_LINARO_DIR failed, exiting ..."; exit 1; }
git checkout -b krogoth remotes/origin/krogoth

echo "Cloning meta-openembedded"
git clone git://git.openembedded.org/meta-openembedded $M_OPENEMBEDDED_DIR || { echo "Error: Cloning meta-openembedded repo failed, exiting ..."; exit 1; }

cd "$M_OPENEMBEDDED_DIR" || { echo "Error: cd-ing into $M_OPENEMBEDDED_DIR failed, exiting ..."; exit 1; }
git checkout -b krogoth remotes/origin/krogoth

mkdir -p "$POKY_CONF_DIR" || { echo "Error: mkdir for $POKY_CONF_DIR failed, exiting ..."; exit 1; }
cd "$POKY_CONF_DIR" || { echo "Error: cd-ing into $POKY_CONF_DIR failed, exiting ..."; exit 1; }

echo "Copying configuration files"
echo "Source: meta-renesas/meta-rcar-gen3/docs/sample/conf/h3ulcb/poky-gcc/bsp"
cp "$DIR/"*.conf $POKY_CONF_DIR || { echo "Error: Copying configuration files failed, exiting ..."; exit 1; }

cd "$POKY_DIR" || { echo "Error: cd-ing into $POKY_DIR failed, exiting ..."; exit 1; }

echo "Applying a trivial patch for poky"
patch -p1 <"$DIR/poky.patch" || { echo "Error: Patching poky failed, try to apply the patch manually. exiting ..."; exit 1; }

echo "Setting up build environment"
source oe-init-build-env

echo "Initiating Build ..."
echo "Binaries can be found at: $POKY_DIR/build/tmp/deploy/images/h3ulcb"
bitbake core-image-minimal

echo "Done :)"

