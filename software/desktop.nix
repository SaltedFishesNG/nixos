{ pkgs, lib, userName, ... }:
{
  # boot.blacklistedKernelModules = [ "i915" ];

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    adw-gtk3
    bibata-cursors
    brightnessctl
    foot
    fuzzel
    mako
    nautilus
    playerctl
    swaybg
    swayidle
    swaylock
    waybar
    wezterm
    xwayland-satellite
  ];

  programs = {
    niri.enable = true;
    dconf.profiles.user.databases = [{
      settings = {
        "org/gnome/desktop/interface" = {
          gtk-theme = "adw-gtk3";
          icon-theme = "Adwaita";
          cursor-theme = "Bibata-Modern-Ice";
          cursor-size = lib.gvariant.mkInt32 20;
        };
      };
    }];
  };

  services.gvfs.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${lib.getExe pkgs.tuigreet} -c niri-session";
      user = "${userName}";
    };
  };
  systemd.services.greetd.serviceConfig = {
    Type = lib.mkForce "simple";
    ExecStartPre = [ "-${pkgs.coreutils}/bin/kill -SIGRTMIN+21 1" ];
    ExecStopPost = [ "-${pkgs.coreutils}/bin/kill -SIGRTMIN+20 1" ];
  };
}
