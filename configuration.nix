{ pkgs, lib, userName, ... }:
{
  time.timeZone = "UTC";
  i18n.defaultLocale = "C.UTF-8";
  console.keyMap = "us";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    initrd.systemd.enable = true;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 25;
    loader.efi.canTouchEfiVariables = true;
  };
  system.nixos-init.enable = true;
  system.etc.overlay.enable = true;
  systemd.enableEmergencyMode = false;

  networking = {
    hostName = "Gamma";
    useDHCP = false;
    dhcpcd.enable = false;
    resolvconf.enable = false;
    networkmanager.enable = false;
    wireless.iwd.enable = true;
    nftables.enable = true;
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
      networkConfig.KeepConfiguration = "dynamic";
      dhcpV4Config.RouteMetric = 2048;
      dhcpV6Config.RouteMetric = 2048;
    };
  };

  users.mutableUsers = false;
  users.users.${userName} = {
    password = "none";
    isNormalUser = true;
    extraGroups = [ "audio" "video" "wheel" ];
    shell = pkgs.fish;
  };
  programs.fish = {
    enable = true;
    shellInit = "set fish_color_command blue";
  };

  security = {
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
    rtkit.enable = true;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30min
    HibernateMode=shutdown platform
  '';
  services = {
    logind.settings.Login = {
      HandlePowerKey = "hibernate";
      HandleLidSwitch = "suspend-then-hibernate";
      IdleActionSec = "15min";
      IdleAction = "suspend-then-hibernate";
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
    udisks2.enable = true;
    udev.packages = [ pkgs.usbutils ];
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      fira-code
      font-awesome
      iosevka
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      sarasa-gothic
      source-code-pro
    ];
    fontconfig.defaultFonts = pkgs.lib.mkForce {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "Fira Code" "Iosevka" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  documentation = {
    enable = false;
    man.enable = false;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    channel.enable = false;
    settings = {
      substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
      trusted-users = [ "root" "${userName}" ];
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
