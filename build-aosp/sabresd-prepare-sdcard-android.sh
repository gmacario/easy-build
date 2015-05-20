#!/bin/bash
# ==============================================================================
# Purpose:
# Prepare a SD-Card with the Android system for deployment
# onto a Freescale SabreSD target
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

IMAGES_ARCHIVE=android_kk4.4.3_2.0.0-ga_images_6qsabresd.gz
#IMAGES_MD5SUM=xxx

#IMAGES_ARCHIVE2=tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd.tar.gz

UBOOT_FILE=tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd/u-boot-imx6q.imx
BOOT_IMAGE=tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd/SD/boot-imx6q.img
SYSTEM_IMAGE=tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd/SD/system.img
RECOVERY_IMAGE=tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd/SD/recovery-imx6q.img

# ----------------------------------------------------------------------------------
# END OF CONFIGURABLE PARAMETERS
# ----------------------------------------------------------------------------------

#set -x
set -e

echo "DEBUG: SDCARD=${SDCARD}"
echo "DEBUG: SDCARD_SIZE=${SDCARD_SIZE}"
echo "DEBUG: IMAGES_DIR=${IMAGES_DIR}"
echo "DEBUG: UBOOT_FILE=${UBOOT_FILE}"
echo "DEBUG: DTBS_ARCHIVE=${DTBS_ARCHIVE}"
echo "DEBUG: DTB_FILE=${DTB_FILE}"
echo "DEBUG: UIMAGE_FILE=${UIMAGE_FILE}"
echo "DEBUG: ROOTFS_FILE=${ROOTFS_FILE}"

# Sanity checks

if [ -e "${UBOOT_FILE}" ]; then
    echo "DEBUG: Skipping extraction of IMAGES_ARCHIVE"
else
if [ "${IMAGES_ARCHIVE}" = "" ]; then
    echo "ERROR: Please set IMAGES_ARCHIVE environment variable"
    exit 1
fi
# TODO: md5sum ${IMAGES_ARCHIVE}
mkdir -p tmp
tar -C tmp/ -xvzf ${IMAGES_ARCHIVE}
tar -C tmp/ -xvzf tmp/android_KK4.4.3_2.0.0-ga_core_image_6qsabresd.tar.gz
#tar -C tmp/ -xvzf tmp/android_KK4.4.3_2.0.0-ga_full_image_6qsabresd.tar.gz
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
sudo dd if=/dev/zero of=${SDCARD} bs=512 count=1024

echo "INFO: Creating partitions on ${SDCARD}"
#
# Start  | End     | Number of | Size   | Purpose
# sector | sector  | sectors   |        |
# --------------------------------------------------------------------------------------------------
# 0      | 2047    | 2048      | 1 MB   | Unpartitioned space for U-Boot and U-Boot envvars
# 2048   | 18431   | 16384     | 8 MB   | Primary partition 1 for boot.img
# 18432  | 34815   | 16384     | 8 MB   | Primary partition 2 for recovery.img
# 34816  | ?       | ?         | 512 MB | TODO: Logic partition 5 (extended 3) for system.img
# ?      | ?       | ?         | 512 MB | TODO: Logic partition 6 (extended 3)
# ?      | ?       | ?         | 8 MB   | TODO: Logic partition 7 (extended 3)
# ?      | ?       | ?         | 4 MB   | TODO: Logic partition 8 (extended 3)
# ?      | ?       | ?         | ?      | TODO: Primary partition 4
#
# TODO: Complete layout for partitions Logic 5 up to Primary 4
#
sudo fdisk ${SDCARD} <<END
n
p
1
2048
18431
n
p
2
18432
34815
n
p
3


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
    echo "DEBUG: Load the memory card with ${UBOOT_FILE}"
    #
    # For U-Boot 2009.08 (i.e. with Android 4.0.2)
    #sudo dd if=${UBOOT_FILE} of=${SDCARD} bs=512 seek=2 skip=2
    #
    # For later U-Boot versions (i.e. with Android 4.4.3)
    sudo dd if=${UBOOT_FILE} of=${SDCARD} bs=512 seek=2 conv=fsync
fi
# TODO: Change U-Boot envvars

if [ "${BOOT_IMAGE}" != "" ]; then
    echo "DEBUG: Load Partition 1 with ${BOOT_IMAGE}"
    sudo dd if=${BOOT_IMAGE} of=${SDCARD}1 bs=512 conv=fsync
fi

if [ "${RECOVERY_IMAGE}" != "" ]; then
    echo "DEBUG: Load Partition 2 with ${RECOVERY_IMAGE}"
    sudo dd if=${RECOVERY_IMAGE} of=${SDCARD}2 bs=512 conv=fsync
fi

echo "INFO: Please install the SD-Card onto the target board"

# EOF
