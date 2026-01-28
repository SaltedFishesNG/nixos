let
  mountOptions = [
    "noatime"
    "compress-force=zstd"
  ];
  btrfs = {
    type = "btrfs";
    extraArgs = [ "-f" ];
    subvolumes = {
      "/nix" = {
        mountpoint = "/nix";
        mountOptions = mountOptions;
      };
      "/persist" = {
        mountpoint = "/persist";
        mountOptions = mountOptions;
      };
      "/tmp" = {
        mountpoint = "/tmp";
        mountOptions = mountOptions;
      };
      "/swap" = {
        mountpoint = "/swap";
        mountOptions = [ "noatime" ];
        swap.swapfile.size = "16G";
      };
    };
  };
in
{
  disko.devices.nodev."/" = {
    fsType = "tmpfs";
    mountOptions = [
      "size=50%"
      "defaults"
      "mode=755"
    ];
  };

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/sda";
    content.type = "gpt";
    content.partitions = {
      ESP = {
        size = "1000M";
        type = "EF00";
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
          mountOptions = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };
      primary = {
        size = "100%";
        content = {
          type = "luks";
          name = "primary";
          settings = {
            allowDiscards = true;
            bypassWorkqueues = true;
          };
          content = btrfs;
        };
      };
    };
  };
}
