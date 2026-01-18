{
  pkgs,
  lib,
  userName,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    adw-gtk3
    bibata-cursors
    brightnessctl
    file-roller
    fuzzel
    mako
    nautilus
    pavucontrol
    qgnomeplatform
    qgnomeplatform-qt6
    swaybg
    swayidle
    swaylock
    waybar
    wezterm
    xwayland-satellite
  ];

  programs = {
    dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            gtk-theme = "adw-gtk3";
            icon-theme = "Adwaita";
            cursor-theme = "Bibata-Modern-Ice";
            cursor-size = lib.gvariant.mkInt32 20;
          };
        };
      }
    ];
    niri.enable = true;
  };

  services = {
    playerctld.enable = true;
    gvfs.enable = true;
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${lib.getExe pkgs.tuigreet} -c niri-session";
        user = "${userName}";
      };
    };
  };
  systemd.services.greetd.serviceConfig = {
    Type = lib.mkForce "simple";
    ExecStartPre = [ "-${pkgs.coreutils}/bin/kill -SIGRTMIN+21 1" ];
    ExecStopPost = [ "-${pkgs.coreutils}/bin/kill -SIGRTMIN+20 1" ];
  };

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "gnome";
  };
}
