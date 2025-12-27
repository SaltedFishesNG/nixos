{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "corefonts" # unityhub
    "nvidia-settings"
    "nvidia-x11"
    "qq"
    "steam"
    "steam-unwrapped"
    "unityhub"
  ];

  # It is suggested to use the open source kernel modules on Turing or later GPUs (RTX series, GTX 16xx)
  hardware.nvidia.open = false;
  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [
    qq
    unityhub
  ];

  programs.steam = {
    enable = true;
    extest.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
