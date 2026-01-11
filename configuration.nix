{
  pkgs,
  lib,
  config,
  userName,
  ...
}:
{
  time.timeZone = "UTC";
  i18n.defaultLocale = "C.UTF-8";
  console.keyMap = "us";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    initrd.systemd.enable = true;
    loader.timeout = 1;
    loader.grub = {
      enable = true;
      configurationLimit = 3;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
    # loader.systemd-boot.enable = true;
    # loader.systemd-boot.configurationLimit = 3;
    # loader.efi.canTouchEfiVariables = true;
  };
  system.nixos-init.enable = true;
  system.etc.overlay.enable = true;
  systemd.enableEmergencyMode = false;

  networking = {
    hostName = "Image";
    useDHCP = false;
    dhcpcd.enable = false;
    firewall.enable = false;
    resolvconf.enable = false;
    networkmanager.enable = false;
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
        Type = "ether !loopback !bridge !none";
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIObSiBahejD/fe1MOfbrW1XF29t/4yRAPcwphHEFVqET main@saltedfishes.com"
    ];
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
  programs.fish = {
    enable = true;
    shellInit = "set fish_color_command blue";
  };

  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = lib.mkForce "prohibit-password";
      };
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
  };

  security.sudo-rs = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  documentation = {
    enable = false;
    man.enable = false;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    channel.enable = false;
    settings = {
      trusted-users = [
        "root"
        "${userName}"
      ];
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
