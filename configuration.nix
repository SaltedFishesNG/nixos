{ pkgs, lib, ... }:

{
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "zh_CN.UTF-8";
  console.keyMap = "us";

  networking.hostName = "Gamma";
  networking.networkmanager.enable = true;

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    tmp.cleanOnBoot = true;
    initrd.systemd.enable = true;
    # plymouth.enable = true;
  };
  system.etc.overlay.enable = true;
  system.nixos-init.enable = true;
  services.userborn.enable = true;
  security.shadow.enable = false;

  # 定义电源键和合盖的功能
  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
    HandleLidSwitch = "sleep";
  };

  services.zram-generator = {
    enable = true;
    settings.zram0 = {
      compression-algorithm = "zstd";
      zram-size = "ram";
    };
  };

  services.dbus.implementation = "broker";

  programs.command-not-found.enable = false;

  # 禁用 systemd 救急模式，因为在无状态系统下没有用处
  systemd.enableEmergencyMode = false;

  # 禁用文档
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

  # 设置镜像；启用实验性特性
  nix = {
    package = pkgs.nixVersions.latest;
    channel.enable = false;
    settings = {
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
      pure-eval = true;
      trusted-users = [
        "root"
        "saya"
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

  system.stateVersion = "25.11"; # Did you read the comment?

}
