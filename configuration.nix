{ pkgs, lib, userName, ... }:
{
  time.timeZone = "UTC";
  i18n.defaultLocale = "C.UTF-8";
  console.keyMap = "us";

  boot = {
    tmp.cleanOnBoot = true;
    initrd.systemd.enable = true;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  system.etc.overlay.enable = true;
  system.nixos-init.enable = true;

  users.mutableUsers = false;
  users.users.${userName} = {
    password = "none";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
    ];
  };

  networking = {
    hostName = "Gamma";
    useDHCP = false;
    dhcpcd.enable = false;
    resolvconf.enable = false;
    networkmanager.enable = false;
    wireless.iwd.enable = true;
    # nftables.enable = true;
    useNetworkd = true;
  };
  services.resolved.enable = false;
  environment.etc."resolv.conf".text = ''
    nameserver 1.1.1.1
    nameserver 2606:4700:4700::1111
    nameserver 8.8.8.8
    nameserver 2001:4860:4860::8888
  '';
  systemd.network = {
    enable = true;
    wait-online.enable = false;
    networks."10-physical" = {
      matchConfig = {
        Type = "ether wlan !loopback !bridge !none";
        Name = "!vnet*";
      };
      DHCP = "yes";
      dhcpV4Config.RouteMetric = 2048;
      dhcpV6Config.RouteMetric = 2048;
    };
  };

  services = {
    logind.settings.Login = {
      HandlePowerKey = "suspend";
      HandleLidSwitch = "sleep";
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
    udisks2.enable = true;
    udev.packages = [ pkgs.usbutils ];
    kmscon.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      fira-code
      font-awesome
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = pkgs.lib.mkForce {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "Fira Code" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  systemd.enableEmergencyMode = false;

  documentation = {
    enable = false;
    doc.enable = false;
    nixos.enable = false;
    man.enable = false;
    dev.enable = false;
    info.enable = false;
  };

  security.sudo-rs = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    channel.enable = false;
    settings = {
      # substituters = [
      #   "https://mirror.sjtu.edu.cn/nix-channels/store"
      # ];
      pure-eval = true;
      trusted-users = [
        "root"
        "${userName}"
      ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
        "auto-allocate-uids"
        "cgroups"
        "pipe-operators"
      ];
      builders-use-substitutes = true;
      auto-allocate-uids = true;
      use-cgroups = true;
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/persist/home/${userName}/Projects/nixos";
  };

  system.stateVersion = "26.05";
}
