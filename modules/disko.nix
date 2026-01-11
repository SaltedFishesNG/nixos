{ inputs, ... }:
{
  imports = [ inputs.disko.nixosModules.disko ];

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
    device = "/dev/vda";
    content.type = "gpt";
    content.partitions = {
      boot = {
        size = "1M";
        type = "EF02";
        priority = 0;
      };
      ESP = {
        size = "100M";
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
          type = "btrfs";
          extraArgs = [ "-f" ];
          subvolumes = {
            "/nix" = {
              mountpoint = "/nix";
              mountOptions = [
                "noatime"
                "compress-force=zstd"
                "space_cache=v2"
              ];
            };
            "/persist" = {
              mountpoint = "/persist";
              mountOptions = [
                "noatime"
                "compress-force=zstd"
                "space_cache=v2"
              ];
            };
            "/tmp" = {
              mountpoint = "/tmp";
              mountOptions = [
                "noatime"
                "compress-force=zstd"
                "space_cache=v2"
              ];
            };
            # "/swap" = {
            #   mountpoint = "/swap";
            #   mountOptions = [ "noatime" "compress-force=zstd" "space_cache=v2" ];
            #   swap.swapfile.size = "1G";
            # };
          };
        };
      };
    };
  };
}
