{ pkgs, lib, ... }:
{
  users.mutableUsers = false;
  users.users.saya = {
    password = "none";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "${lib.getExe pkgs.tuigreet} --cmd niri-session";
    };
  };
  systemd.services.greetd.serviceConfig = {
    Type = lib.mkForce "simple";
    ExecStartPre = [ "-${pkgs.coreutils}/bin/kill -SIGRTMIN+21 1" ];
    ExecStopPost = [ "-${pkgs.coreutils}/bin/kill -SIGRTMIN+20 1" ];
  };

  systemd.user.tmpfiles.users.saya.rules = [
    "L+ %h/.icons/default 0755 saya users - ${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice"
  ];

}
