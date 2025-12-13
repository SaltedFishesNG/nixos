{ pkgs, lib, userName, ... }:
{
  time.timeZone = "UTC";
  i18n.defaultLocale = "zh_CN.UTF-8";
  console.keyMap = "us";

  system.nixos-init.enable = true;
  system.etc.overlay.enable = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    initrd.systemd.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  environment.sessionVariables = {
    # workaround for: https://github.com/NixOS/nixpkgs/issues/265366
    LD_LIBRARY_PATH = "${pkgs.systemd}/lib/cryptsetup";
  };

  users.mutableUsers = false;
  users.users.${userName} = {
    password = "none";
    isNormalUser = true;
    extraGroups = [
      "audio"
      "video"
      "wheel"
    ];
  };

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
      serif = [
        "Noto Serif"
        "Noto Serif CJK TC"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Sans CJK TC"
      ];
      monospace = [
        "Fira Code"
        "Noto Sans Mono CJK TC"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  systemd.enableEmergencyMode = false;

  documentation = {
    enable = false;
    man.enable = false;
    doc.enable = false;
    dev.enable = false;
    info.enable = false;
    nixos.enable = false;
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
      pure-eval = true;
      trusted-users = [
        "root"
        "${userName}"
      ];
      auto-optimise-store = true;
      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "flakes"
        "nix-command"
        "pipe-operators"
      ];
      builders-use-substitutes = true;
      auto-allocate-uids = true;
      use-cgroups = true;
    };
  };

  system.stateVersion = "26.05";
}
