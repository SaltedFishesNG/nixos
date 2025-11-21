{ inputs, pkgs, lib, userName, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${system}.default
    foot
    fuzzel
    # mako
    swaybg
    swayidle
    swaylock
    # waybar
    wezterm
    xwayland-satellite
  ];
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "${lib.getExe pkgs.tuigreet} -c niri-session";
    };
  };
  systemd.services.greetd.serviceConfig = {
    Type = lib.mkForce "simple";
    ExecStartPre = [ "-${pkgs.coreutils}/bin/kill -SIGRTMIN+21 1" ];
    ExecStopPost = [ "-${pkgs.coreutils}/bin/kill -SIGRTMIN+20 1" ];
  };

  systemd.user.tmpfiles.users.${userName}.rules = [
    "L+ %h/.icons/default 0755 ${userName} users - ${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice"
  ];
}
