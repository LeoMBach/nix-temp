#! /usr/bin/env bash

if [[ ! $LUKS_PASSWORD ]]; then
    echo "LUKS_PASSWORD is not defined!"
    exit 1
fi

DISK=/dev/nvme0n1

echo "Wiping old partition data..."
sgdisk --clear $DISK
echo ""

echo "Partitioning..."
sgdisk --new 1:1M:+512M --typecode 1:ef00 $DISK
sgdisk --new 2:: --typecode 2:8300 $DISK
echo ""

echo "Encrypting disk..."
echo "$LUKS_PASSWORD" | cryptsetup luksFormat ${DISK}p2
cryptsetup config --label="cryptlvm" ${DISK}p2
echo "$LUKS_PASSWORD" | cryptsetup open ${DISK}p2 cryptlvm
echo ""

echo "Setting up LVM..."
pvcreate /dev/mapper/cryptlvm
vgcreate vg0 /dev/mapper/cryptlvm
lvcreate -L 20G vg0 -n swap
lvcreate -L 120G vg0 -n root
lvcreate -l 100%FREE vg0 -n home
echo ""

echo "Formatting partitions..."
mkfs.fat -F 32 -n boot ${DISK}p1
mkfs.ext4 /dev/vg0/root
mkfs.ext4 /dev/vg0/home
mkswap /dev/vg0/swap
echo ""

echo "Mounting partitions..."
mount /dev/vg0/root /mnt/
mkdir /mnt/boot
mount ${DISK}p1 /mnt/boot
mkdir /mnt/home
mount /dev/vg0/home /mnt/home
echo ""

echo "Enabling swap partition..."
swapon /dev/vg0/swap
echo ""
