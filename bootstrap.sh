#!/bin/bash  -x

yum install -y epel-release
yum install -y parted
whereis parted
# lsblk

# parted /dev/sdb mklabel msdos
# parted /dev/sdb mkpart primary 512 100%
# mkfs.xfs /dev/sdb1
# mkdir /mnt/disk
# echo `blkid /dev/sdb1 | awk '{print$2}' | sed -e 's/"//g'` /mnt/disk   xfs   noatime,nobarrier   0   0 >> /etc/fstab
# mount /mnt/disk
