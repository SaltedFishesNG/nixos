{
  lib,
  pkgs,
  userName,
  ...
}:
let
  useNetworkManager = true;
in
{
  time.timeZone = "UTC";
  i18n.defaultLocale = "C.UTF-8";
  console.keyMap = "us";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    initrd.systemd.enable = true;
    loader.timeout = 2;
    loader.systemd-boot.enable = lib.mkDefault true;
    loader.systemd-boot.configurationLimit = 25;
    loader.efi.canTouchEfiVariables = true;
  };
  system.nixos-init.enable = true;
  system.etc.overlay.enable = true;

  networking = {
    hostName = "Gamma";
    dhcpcd.enable = false;
    resolvconf.enable = false;
    networkmanager.enable = useNetworkManager;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
    nftables.enable = true;
    useNetworkd = (!useNetworkManager);
    useDHCP = (!useNetworkManager);
  };
  systemd.network.enable = (!useNetworkManager);
  services.resolved.enable = false;
  environment.etc."resolv.conf".text = ''
    nameserver 1.1.1.1
    nameserver 2606:4700:4700::1111
    nameserver 8.8.8.8
    nameserver 2001:4860:4860::8888
  '';

  users.mutableUsers = false;
  users.users.${userName} = {
    password = "";
    isNormalUser = true;
    extraGroups = [
      "audio"
      "video"
      "wheel"
    ];
    shell = pkgs.fish;
  };
  programs.fish = {
    enable = true;
    shellInit = "set fish_color_command blue";
  };

  security = {
    rtkit.enable = true;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
  };

  systemd.enableEmergencyMode = false;
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30min
    HibernateMode=shutdown platform
  '';
  services = {
    logind.settings.Login = {
      HandlePowerKey = "hibernate";
      HandleLidSwitch = "suspend-then-hibernate";
    };
    kmscon = {
      enable = true;
      extraOptions = "--term xterm-256color";
    };
    zram-generator = {
      enable = true;
      settings.zram0 = {
        compression-algorithm = "zstd";
        zram-size = "ram";
      };
    };
    userborn.enable = true;
    dbus.implementation = "broker";
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  documentation.nixos.enable = false;
  documentation.man.generateCaches = false; # Slow build due to fish enabling generateCaches

  nix = {
    package = pkgs.nixVersions.latest;
    channel.enable = false;
    settings = {
      substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
      trusted-users = [ "${userName}" ];
      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "flakes"
        "nix-command"
        "no-url-literals"
        "pipe-operators"
      ];
      auto-allocate-uids = true;
      auto-optimise-store = true;
      builders-use-substitutes = true;
      pure-eval = true;
      use-cgroups = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "26.05";
}
