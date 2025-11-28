#!/bin/sh

DEV_PATH="/dev/sda"
LUKS="disable"
USERNAME="saya" # At the same time, you need to modify ./flake.nix.
# BTW, the password is on line 47 of the ./configuration.nix file.

if [ 0 ]; then # Modify to 1
    echo "Please edit this file."
    exit 1
fi

# create partition
parted $DEV_PATH -- mklabel gpt
parted $DEV_PATH -- mkpart ESP fat32 1MB 800MB
parted $DEV_PATH -- set 1 esp on
parted $DEV_PATH -- mkpart primary 800MB 100%
ROOT=$dev"2"

# Linux Unified Key Setup
if [ "$LUKS" == "enable" ]; then
    cryptsetup luksFormat $ROOT
    cryptsetup luksOpen $ROOT root
    ROOT=/dev/mapper/root
fi

# format
mkfs.fat -F 32 -n boot $dev"1"
mkfs.btrfs -L nixos $ROOT

# mount ("Stateless" Operating System)
mount -t tmpfs none /mnt
mkdir -p /mnt/{nix,boot,persist,tmp,swap}
mount /dev/disk/by-label/boot /mnt/boot
mount $ROOT /mnt/nix

# create subvolume
btrfs subvolume create /mnt/nix/nix
btrfs subvolume create /mnt/nix/tmp
btrfs subvolume create /mnt/nix/persist
btrfs subvolume create /mnt/nix/swap

# mount subvolume
umount /mnt/nix
mount -o compress=zstd,noatime,subvol=nix $ROOT /mnt/nix
mount -o compress=zstd,subvol=tmp $ROOT /mnt/tmp
mount -o compress=zstd,subvol=persist $ROOT /mnt/persist
mount -o compress=zstd,subvol=swap $ROOT /mnt/swap

# create swapfile
btrfs filesystem mkswapfile --size 16g --uuid clear /mnt/swap/swapfile

# copy files & install
mkdir -p /mnt/persist/home/$USERNAME/Projects/nixos
cp -r $(dirname $(readlink -f $0))/* /mnt/persist/home/$USERNAME/Projects/nixos
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/persist/home/$USERNAME/Projects/nixos
nixos-install --flake /mnt/persist/home/$USERNAME/Projects/nixos#Gamma
