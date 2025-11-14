#!/bin/sh
# Arch Linux installer script. EFI only!
# Parcevval @2023.

[ -z "$1" ] && printf "Usage: Provide only the drive to install to (i.e /dev/sda, see lsblk)\n\n./archstrap.sh [DRIVE]\n\n" && exit
[ ! -b "$1" ] && printf "Drive $1 is not a valid block device.\n" && exit
printf "\nThis script will erase all data on $1.\nAre you certain? (y/n): " && read CERTAIN
[ "$CERTAIN" != "y" ] && printf "Abort." && exit

disk=$1
boot=${disk}n1p1
swap=${disk}n1p2
root=${disk}n1p3
home=${disk}n1p4

# Cleanup from previous runs. 
swapoff $swap
umount -R /mnt 

# Partition 2G for boot, 24G for swap, 300G for root and rest to home.
# Optimal alignment will change the exact size though!
set -xe
parted -s $disk mklabel gpt
parted -sa optimal $disk mkpart primary fat32 0% 2G
parted -sa optimal $disk mkpart primary linux-swap 2G 26G
parted -sa optimal $disk mkpart primary ext4 26G 326G
parted -sa optimal $disk mkpart primary ext4 326G 100%
parted -s $disk set 1 esp on

# Format the partitions.
mkfs.fat -IF32 $boot
mkswap -f $swap
mkfs.ext4 -F $root
mkfs.ext4 -F $home

# Mount the partitions.
mount $root /mnt
mount -m $boot /mnt/boot
mount -m $home /mnt/home
swapon $swap

# Packages and chroot.
pacstrap /mnt linux-zen linux-firmware networkmanager vim base base-devel git man efibootmgr grub
genfstab -U /mnt > /mnt/etc/fstab

# Enter the system and set up basic locale, passwords and bootloader.
arch-chroot /mnt sh -c 'set -xe;
sed -i "s/^#en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen;
echo "LANG=en_US.UTF-8" > /etc/locale.conf;
locale-gen;

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime;
hwclock --systohc;
systemctl enable NetworkManager;

echo root:root | chpasswd;
echo "nzxt-tower" > /etc/hostname;

mkdir /boot/grub;
grub-mkconfig -o /boot/grub/grub.cfg;
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB;'

# Finalize.
umount -R /mnt
set +xe

printf "
        *--- Installation Complete! ---*
        |                              |
        |        Username: root        |
        |        Password: root        |
        |                              |
        *------------------------------*

"
