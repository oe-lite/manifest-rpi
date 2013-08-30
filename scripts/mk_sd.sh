#!/bin/bash 
set -x -e

# Call this script with something like:
# ./meta/raspberrypi/scripts/mk_sd.sh /dev/mmcblk0 tmp/images/ 

MEDIA=$1
PART_SPAREFS="$1"p4
PART_ROOTFS_SPARE="$1"p3
PART_ROOTFS="$1"p2
PART_BOOTFS="$1"p1
ROOTFS=$2/rpi-raspberrypi-rootfs.tar
BOOTFS=$2/rpi-raspberrypi-bootfs.tar.gz

#######################
ls -l $MEDIA
sleep 5

umount /media/*  || :

dd if=/dev/zero of=$MEDIA bs=512 count=1
partprobe $MEDIA

sfdisk -uM $MEDIA <<EOF
1,192,0C
200,400,83
600,400,83
1000,,83
EOF
sleep 1
partprobe $MEDIA

mkfs.vfat -n boot $PART_BOOTFS
mkfs.ext4 -L rootfs $PART_ROOTFS
mkfs.ext4 -L rootfs_spare $PART_ROOTFS_SPARE
mkfs.ext4 -L spare $PART_SPAREFS

[ -r $ROOTFS ]
mkdir -p /mnt/tmp-sdrootfs
mount -t ext4 $PART_ROOTFS /mnt/tmp-sdrootfs
tar --strip-components=1 -xf $ROOTFS -C /mnt/tmp-sdrootfs
umount /mnt/tmp-sdrootfs
rm -rf /mnt/tmp-sdrootfs

[ -r $BOOTFS ]
mkdir -p /mnt/tmp-sdrootfs
mount -t vfat $PART_BOOTFS /mnt/tmp-sdrootfs
tar --strip-components=1 -xzf $BOOTFS -C /mnt/tmp-sdrootfs
umount /mnt/tmp-sdrootfs
rm -rf /mnt/tmp-sdrootfs
