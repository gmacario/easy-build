#!/bin/bash
# ==============================================================================
# Project: easy-build
#
# Subproject: build-android-kk443-sabresd
#
# Purpose:
# Prepare a SD-Card suitable for booting the Android operating system
# onto a Freescale SabreSD target board
#
# See also:
# http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=RDIMX6SABREBRD
# ==============================================================================

# ----------------------------------------------------------------------------------
# CONFIGURABLE PARAMETERS
# ----------------------------------------------------------------------------------

#SDCARD=/dev/sdb
#SDCARD_SIZE=4000317440
TMP_MOUNT=/tmp/rootfs

## ANDROID KK443 PREBUILT BINARIES FROM FREESCALE
##
#IMAGES_ARCHIVE=android_kk4.4.3_2.0.0-ga_images_6qsabresd.gz
#IMAGES_ARCHIVE2=tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd.tar.gz
##
#UBOOT_FILE=tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd/u-boot-imx6q.imx
#BOOT_IMAGE=tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd/SD/boot-imx6q.img
#RECOVERY_IMAGE=tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd/SD/recovery-imx6q.img
##SYSTEM_IMAGE=tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd/SD/system.img

## ANDROID L500 PREBUILT BINARIES FROM FREESCALE
#
IMAGES_ARCHIVE=android_L5.0.0_1.0.0-ga_images_6qsabresd.tar.gz
IMAGES_ARCHIVE2=tmp/android_L5.0.0_1.0.0-ga_full_image_6qsabresd.tar.gz
#
UBOOT_FILE=tmp/android_L5.0.0_1.0.0-ga_full_image_6qsabresd/u-boot-imx6q.imx
BOOT_IMAGE=tmp/android_L5.0.0_1.0.0-ga_full_image_6qsabresd/SD/boot-imx6q.img
RECOVERY_IMAGE=tmp/android_L5.0.0_1.0.0-ga_full_image_6qsabresd/SD/recovery-imx6q.img
SYSTEM_IMAGE=tmp/android_L5.0.0_1.0.0-ga_full_image_6qsabresd/SD/system.img

## ANDROID KK443 IMAGES BUILT FROM SOURCES
##
#IMAGES_PATH=${PWD}/tmp/myandroid-kk443-sabresd
#UBOOT_FILE=${IMAGES_PATH}/u-boot-imx6q.imx
#BOOT_IMAGE=${IMAGES_PATH}/boot-imx6q.img
#RECOVERY_IMAGE=${IMAGES_PATH}/recovery-imx6q.img
#SYSTEM_IMAGE=${IMAGES_PATH}/system.img

# ----------------------------------------------------------------------------------
# END OF CONFIGURABLE PARAMETERS
# ----------------------------------------------------------------------------------

#set -x
set -e

echo "DEBUG: SDCARD=${SDCARD}"
echo "DEBUG: SDCARD_SIZE=${SDCARD_SIZE}"
echo "DEBUG: IMAGES_ARCHIVE=${IMAGES_ARCHIVE}"
echo "DEBUG: IMAGES_ARCHIVE2=${IMAGES_ARCHIVE2}"
#echo "DEBUG: IMAGES_DIR=${IMAGES_DIR}"
echo "DEBUG: UBOOT_FILE=${UBOOT_FILE}"
#echo "DEBUG: DTBS_ARCHIVE=${DTBS_ARCHIVE}"
#echo "DEBUG: DTB_FILE=${DTB_FILE}"
#echo "DEBUG: UIMAGE_FILE=${UIMAGE_FILE}"
#echo "DEBUG: ROOTFS_FILE=${ROOTFS_FILE}"
echo "DEBUG: BOOT_IMAGE=${BOOT_IMAGE}"
echo "DEBUG: RECOVERY_IMAGE=${RECOVERY_IMAGE}"
echo "DEBUG: SYSTEM_IMAGE=${SYSTEM_IMAGE}"

# Sanity checks

if [ -e "${UBOOT_FILE}" ]; then
    true # && echo "DEBUG: Skipping extraction of IMAGES_ARCHIVE"
else
    if [ "${IMAGES_ARCHIVE}" = "" ]; then
        echo "ERROR: Please set IMAGES_ARCHIVE environment variable"
        exit 1
    fi
    # TODO: md5sum ${IMAGES_ARCHIVE}
    mkdir -p tmp
# FIXME
#    if [ "${IMAGES_ARCHIVE2} != "" -a ! -e "${IMAGES_ARCHIVE2}" ]; then
#        echo "DEBUG: Extracting images from ${IMAGES_ARCHIVE}"
#        tar -C tmp/ -xvzf "${IMAGES_ARCHIVE}"
#    fi
    if [ "${IMAGES_ARCHIVE2}" != "" ]; then
        echo "DEBUG: Extracting images from ${IMAGES_ARCHIVE2}"
        tar -C tmp/ -xvzf "${IMAGES_ARCHIVE2}"
    fi
fi

if [ "${SDCARD}" = "" ]; then
    echo "ERROR: Please set SDCARD environment variable"
    exit 1
fi
if [ ! -e "${SDCARD}" ]; then
    echo "ERROR: Cannot find memory card: ${SDCARD}"
    exit 1
fi
sz=$(sudo fdisk -l ${SDCARD} | grep '^Disk .* bytes$' | cut -d ' ' -f5)
if [ "$sz" = "" ]; then
    echo "ERROR: Cannot access ${SDCARD}"
    exit 1
fi
if [ "${SDCARD_SIZE}" = "" ]; then
    echo "ERROR: Please set environment variable SDCARD_SIZE=$sz"
    exit 1
fi
if [ "$sz" != "${SDCARD_SIZE}" ]; then
    echo "ERROR: Wrong SD-Card size ($sz bytes) - ${SDCARD_SIZE} expected"
    exit 1
fi

echo "DEBUG: Make sure that there are no mounted partitions of ${SDCARD}"
ls ${SDCARD}* | while read f; do
    sudo sh -c "umount $f 2>/dev/null || true"
done

echo "INFO: Erasing partitions on ${SDCARD}"
sudo dd if=/dev/zero of=${SDCARD} bs=1024 count=1024

echo "INFO: Creating partitions on ${SDCARD}"
#
# Part |  Start |    End | Number of |    Size | Purpose
#      | Sector | Sector | 1k-Blocks |         |
# --------------------------------------------------------------------------------------------------
#  N/A |      0 |   2047 |      1024 |    1 MB | Unpartitioned space - U-Boot and U-Boot envvars
#    1 |   2048 |  18431 |      8192 |    8 MB | Primary partition 1 - boot.img
#    2 |  18432 |  34815 |      8192 |    8 MB | Primary partition 2 - recovery.img
#    3 |  34816 |      ? |   1310720 | 1280 MB | Extended partition
#    4 |      ? |      ? |         ? |       ? | Primary partition 4 (up to end of SD-Card) for DATA
#    5 |      ? |      ? |    524288 |  512 MB | Logical partition 5 (extended 3) - system.img
#    6 |      ? |      ? |    524288 |  512 MB | Logical partition 6 (extended 3) - CACHE
#    7 |      ? |      ? |      8192 |    8 MB | Logical partition 7 (extended 3) - VENDOR
#    8 |      ? |      ? |      6144 |    6 MB | Logical partition 8 (extended 3) - MISC
#    9 |      ? |      ? |      2048 |    2 MB | Logical partition 9 (extended 3) - DATAFOOTER
#
#
sudo fdisk ${SDCARD} <<END
n
p
1
2048
+8M
n
p
2

+8M
n
e
3

+1280M
n
p
4


n
l

+512M
n
l

+512M
n
l

+8M
n
l

+6M
n
l

+2M
t
1
83
p
w
END

#echo "DEBUG: Verifying partitions on SDCARD"
#sudo fdisk -l "${SDCARD}"

#set -x

if [ "${UBOOT_FILE}" != "" ]; then
    echo "DEBUG: Loading memory card with ${UBOOT_FILE}"
    #
    # For U-Boot 2009.08 (i.e. with Android 4.0.2)
    #sudo dd if=${UBOOT_FILE} of=${SDCARD} bs=512 seek=2 skip=2
    #
    # For later U-Boot versions (i.e. with Android 4.4.3)
    sudo dd if=${UBOOT_FILE} of=${SDCARD} bs=512 seek=2 conv=fsync
fi
# TODO: Change U-Boot envvars

if [ "${BOOT_IMAGE}" != "" ]; then
    echo "DEBUG: Loading Partition 1 with ${BOOT_IMAGE}"
    sudo dd if=${BOOT_IMAGE} of=${SDCARD}1
fi

if [ "${RECOVERY_IMAGE}" != "" ]; then
    echo "DEBUG: Loading Partition 2 with ${RECOVERY_IMAGE}"
    sudo dd if=${RECOVERY_IMAGE} of=${SDCARD}2
fi

echo "DEBUG: Formatting Partition 4 (/data)"
sudo mkfs -t ext4 -L "data" "${SDCARD}4"

if [ "${SYSTEM_IMAGE}" != "" ]; then
    echo "DEBUG: Loading Partition 5 (/system) with ${SYSTEM_IMAGE}"
    sudo dd if=${SYSTEM_IMAGE} of=${SDCARD}5
fi

echo "DEBUG: Formatting Partition 6 (/cache)"
sudo mkfs -t ext4 -L "ccache" "${SDCARD}6"

echo "DEBUG: Formatting Partition 7 (/vendor)"
sudo mkfs -t ext4 -L "vendor" "${SDCARD}7"

echo "DEBUG: Zeroing Partition 8 (recovery store)"
sudo dd if=/dev/zero of=${SDCARD}8 bs=1024 count=6144 || true

echo "DEBUG: Zeroing Partition 9 (crypto footer)"
sudo dd if=/dev/zero of=${SDCARD}9 bs=1024 count=2048 || true

sync
sync

echo "INFO: Please install the SD-Card onto the target board"

# EOF
