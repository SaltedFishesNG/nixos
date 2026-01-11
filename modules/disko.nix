{ inputs, ... }:
{
  imports = [ inputs.disko.nixosModules.disko ];

  disko.devices.nodev."/" = {
    fsType = "tmpfs";
    mountOptions = [
      "size=100%"
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
          ################################################
          # If you do not need LUKS, delete this section.
          type = "luks";
          name = "primary";
          settings = {
            allowDiscards = true;
            bypassWorkqueues = true;
          };
        };
        content.content = {
          #################################################
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
            "/swap" = {
              mountpoint = "/swap";
              mountOptions = [
                "noatime"
                "compress-force=zstd"
                "space_cache=v2"
              ];
              swap.swapfile.size = "16G";
            };
          };
        };
      };
    };
  };
}
