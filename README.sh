# 分区
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart ESP fat32 1MB 800MB
parted /dev/sda -- set 1 esp on
parted /dev/sda -- mkpart primary 800MB 100%

# 加密 /dev/sda2 -> /dev/mapper/root
# cryptsetup luksFormat /dev/sda2
# cryptsetup luksOpen /dev/sda2 root

# 格式化
mkfs.fat -F 32 -n boot /dev/sda1
mkfs.btrfs -L nixos /dev/sda2

# 挂载 (无状态系统版)
mount -t tmpfs none /mnt
mkdir -p /mnt/{nix,boot,persist,tmp,swap}
mount /dev/disk/by-label/boot /mnt/boot
mount /dev/sda2 /mnt/nix

#创建子卷
btrfs subvolume create /mnt/nix/nix
btrfs subvolume create /mnt/nix/tmp
btrfs subvolume create /mnt/nix/persist
btrfs subvolume create /mnt/nix/swap

# 挂载子卷
umount /mnt/nix
mount -o compress=zstd,noatime,subvol=nix /dev/sda2 /mnt/nix
mount -o compress=zstd,subvol=tmp /dev/sda2 /mnt/tmp
mount -o compress=zstd,subvol=persist /dev/sda2 /mnt/persist
mount -o compress=zstd,subvol=swap /dev/sda2 /mnt/swap

# 生成 swapfile
btrfs filesystem mkswapfile --size 16g --uuid clear /mnt/swap/swapfile

nixos-generate-config --root /mnt
# mkdir -p /mnt/persist/home/saya/Projects/nixos
# cp /mnt/etc/nixos/hardware-configuration.nix /mnt/persist/home/saya/Projects/nixos
# nixos-install --flake /mnt/persist/home/saya/Projects/nixos#Gamma
