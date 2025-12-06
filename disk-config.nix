{
  disko.devices.nodev."/" = {
    fsType = "tmpfs";
    mountOptions = [ "defaults" "mode=755" "nodev" "nosuid" ];
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
          mountOptions = [ "fmask=0077" "dmask=0077" ];
        };
      };
      ##############################
      # root = {
      #   size = "100%";
      #   content = {
      ##############################
      luks = {
        size = "100%";
        content = {
          type = "luks";
          name = "crypted";
          settings = {
            allowDiscards = true;
            bypassWorkqueues = true;
          };
          # passwordFile = "/tmp/secret.key";
        };
        content.content = {
      ##############################
          type = "btrfs";
          extraArgs = [ "-f" ];
          subvolumes = {
            "/nix" = {
              mountpoint = "/nix";
              mountOptions = [ "noatime" "compress-force=zstd" "space_cache=v2" ];
            };
            "/tmp" = {
              mountpoint = "/tmp";
              mountOptions = [ "noatime" "compress-force=zstd" "space_cache=v2" ];
            };
            "/persist" = {
              mountpoint = "/persist";
              mountOptions = [ "noatime" "compress-force=zstd" "space_cache=v2" ];
            };
            "/swap" = {
              mountpoint = "/swap";
              mountOptions = [ "noatime" "compress-force=zstd" "space_cache=v2" ];
              swap.swapfile.size = "16G";
            };
          };
        };
      };
    };
  };
}
