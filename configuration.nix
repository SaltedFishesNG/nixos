{
  pkgs,
  userName,
  lib,
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
    loader.systemd-boot.enable = lib.mkDefault true;
    loader.systemd-boot.configurationLimit = 25;
    loader.efi.canTouchEfiVariables = true;
  };
  system.nixos-init.enable = true;
  system.etc.overlay.enable = true;

  networking = {
    hostName = lib.mkDefault "NixOS";
    dhcpcd.enable = false;
    resolvconf.enable = false;
    networkmanager.enable = false;
    wireless.iwd.enable = true;
    nftables.enable = true;
    useNetworkd = true;
    useDHCP = true;
  };
  systemd.network.enable = true;
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIObSiBahejD/fe1MOfbrW1XF29t/4yRAPcwphHEFVqET main@saltedfishes.com"
    ];
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
    doas = {
      enable = true;
      extraConfig = "permit persist :wheel";
    };
    rtkit.enable = true;
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
  };

  systemd.enableEmergencyMode = false;
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
  '';
  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = lib.mkForce "prohibit-password";
      };
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

  documentation.enable = false;
  documentation.man.enable = false;

  nix = {
    package = pkgs.nixVersions.latest;
    channel.enable = false;
    settings = {
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
