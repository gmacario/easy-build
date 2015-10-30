#!/bin/bash

set -e

echo "DEBUG: startup2.sh BEGIN"

AOSP_BACKUP=~/shared/extra/bk-aosp-20150524-1507.tar.gz
KERNELIMX_BACKUP=~/shared/extra/bk-kernelimx-20150421-1557.tar.gz
UBOOTIMX_BACKUP=~/shared/extra/bk-ubootimx-20150421-1601.tar.gz

FSL_PATCHES_SCRIPT="~/shared/extra/android_KK4.4.3_2.0.0-ga_core_source/code/KK4.4.3_2.0.0-ga/and_patch.sh"
FSL_PATCHES_TAR1=~/shared/android_KK4.4.3_2.0.0-ga_core_source.gz
FSL_PATCHES_TAR2=~/shared/extra/android_KK4.4.3_2.0.0-ga_core_source/code/KK4.4.3_2.0.0-ga.tar.gz

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git config --global color.ui auto

if [ ! -e ~/shared/extra/.aosp_checkout ]; then
    cd ~/shared/myandroid
    if [ "${AOSP_BACKUP}" != "" ] && [ -e "${AOSP_BACKUP}" ]; then
        echo "INFO: Restoring AOSP sources from ${AOSP_BACKUP}"
        tar -xvzf ${AOSP_BACKUP}
    else
        echo "INFO: Checking out AOSP sources from remote git repositories"
        repo init -u https://android.googlesource.com/platform/manifest -b android-4.4.3_r1
        repo sync -j16
    fi
    touch ~/shared/extra/.aosp_checkout
fi
if [ ! -e ~/shared/extra/.aosp_update ]; then
    cd ~/shared/myandroid
    echo "INFO: Syncing up AOSP sources from remote git repositories"
    repo sync -j16
    AOSP_BACKUP_NEW=~/shared/extra/bk-aosp-$(date '+%Y%m%d-%H%M').tar.gz
    echo "INFO: Backing up AOSP sources to ${AOSP_BACKUP_NEW}"
    tar -cvzf "${AOSP_BACKUP_NEW}" .
    touch ~/shared/extra/.aosp_update
fi
if [ ! -e ~/shared/extra/.uboot_imx_checkout ]; then
    cd ~/shared/myandroid/bootable/bootloader
    if [ "${UBOOTIMX_BACKUP}" != "" ] && [ -e "${UBOOTIMX_BACKUP}" ]; then
        echo "INFO: Restoring uboot-imx sources from ${UBOOTIMX_BACKUP}"
        tar -xvzf ${UBOOTIMX_BACKUP}
    else
        echo "INFO: Checking out uboot-imx sources from git"
        git clone git://git.freescale.com/imx/uboot-imx.git uboot-imx
        cd uboot-imx && git checkout kk4.4.3_2.0.0-ga && cd -
        UBOOTIMX_BACKUP_NEW=bk-ubootimx-$(date '+%Y%m%d-%H%M').tar.gz kernel_imx
        # TODO: tar -cvzf  ${UBOOTIMX_BACKUP_NEW} uboot-imx
    fi
    touch ~/shared/extra/.uboot_imx_checkout
fi
if [ ! -e ~/shared/extra/.kernel_imx_checkout ]; then
    cd ~/shared/myandroid
    if [ "${KERNELIMX_BACKUP}" != "" ] && [ -e "${KERNELIMX_BACKUP}" ]; then
        echo "INFO: Restoring kernel_imx sources from ${KERNELIMX_BACKUP}"
        tar -xvzf ${KERNELIMX_BACKUP}
    else
        echo "INFO: Checking out kernel_imx sources from git"
        git clone git://git.freescale.com/imx/linux-2.6-imx.git kernel_imx
        cd kernel_imx && git checkout kk4.4.3_2.0.0-ga && cd -
        KERNELIMX_BACKUP_NEW=bk-kernelimx-$(date '+%Y%m%d-%H%M').tar.gz kernel_imx
        # TODO: tar -cvzf  ${KERNELIMX_BACKUP_NEW} kernel_imx
    fi
    touch ~/shared/extra/.kernel_imx_checkout
fi
if [ ! -e ~/shared/extra/.aosp_fsl_patched ]; then
    if [ ! -x "${FSL_PATCHES_SCRIPT}" ]; then
        if [ ! -e "${FSL_PATCHES_TAR2}" ]; then
            echo "INFO: Extracting ${FSL_PATCHES_TAR1}"
            cd ~/shared/extra
            tar -xvzf "${FSL_PATCHES_TAR1}"
        fi
        echo "INFO: Extracting ${FSL_PATCHES_TAR2}"
        cd ~/shared/extra/android_KK4.4.3_2.0.0-ga_core_source/code
        tar -xvzf "${FSL_PATCHES_TAR2}"
    fi
    echo "TODO: Applying patches to AOSP sources"
    cd ~/shared/myandroid
    source ~/shared/extra/android_KK4.4.3_2.0.0-ga_core_source/code/KK4.4.3_2.0.0-ga/and_patch.sh
    c_patch ~/shared/extra/android_KK4.4.3_2.0.0-ga_core_source/code/KK4.4.3_2.0.0-ga imx_KK4.4.3_2.0.0-ga 2>c_patch_err.txt >c_patch_out.txt
    
    # Comment line "#include $(call first ...)" in hardware/ti/wpan/Android.mk
    sed -i.ORIG 's/^include/#include/' hardware/ti/wpan/Android.mk

    touch ~/shared/extra/.aosp_fsl_patched
fi

if [ -e ~/shared/extra/.do_build_sabresd_6dq ]; then
    cd ~/shared/myandroid && source build/envsetup.sh && \
        lunch sabresd_6dq-eng && time make 2>&1 | tee build_sabresd_6dq_android.log
fi

#/bin/bash -l

echo "DEBUG: startup2.sh END"

# EOF
