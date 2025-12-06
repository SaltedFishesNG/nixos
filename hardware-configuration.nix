{ config, lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_usb_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "mode=755"
      "nodev"
      "nosuid"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8569-7289";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/994b5d4e-6b89-4f86-b319-30f476723ff0";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "noatime"
      "compress-force=zstd"
      "space_cache=v2"
    ];
  };

  fileSystems."/tmp" = {
    device = "/dev/disk/by-uuid/994b5d4e-6b89-4f86-b319-30f476723ff0";
    fsType = "btrfs";
    options = [
      "subvol=tmp"
      "noatime"
      "compress-force=zstd"
      "space_cache=v2"
    ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/994b5d4e-6b89-4f86-b319-30f476723ff0";
    fsType = "btrfs";
    options = [
      "subvol=persist"
      "noatime"
      "compress-force=zstd"
      "space_cache=v2"
    ];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/994b5d4e-6b89-4f86-b319-30f476723ff0";
    fsType = "btrfs";
    options = [
      "subvol=swap"
      "noatime"
      "compress-force=zstd"
      "space_cache=v2"
    ];
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
