{
  nixpkgs.config.allowUnfree = true;

  # It is suggested to use the open source kernel modules on Turing or later GPUs (RTX series, GTX 16xx)
  hardware.nvidia.open = false;
  services.xserver.videoDrivers = [ "nvidia" ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };
}
