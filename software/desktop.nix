{
  lib,
  pkgs,
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

  systemd.services.greetd.serviceConfig = {
    Type = lib.mkForce "simple";
    ExecStartPre = [ "-${pkgs.coreutils}/bin/kill -SIGRTMIN+21 1" ];
    ExecStopPost = [ "-${pkgs.coreutils}/bin/kill -SIGRTMIN+20 1" ];
  };
  services = {
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${lib.getExe pkgs.tuigreet}";
        user = "${userName}";
      };
      useTextGreeter = true;
    };
    gvfs.enable = true;
    playerctld.enable = true;
    udev.packages = [ pkgs.usbutils ];
    udisks2.enable = true;

    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      displayManager.startx.enable = true;
      windowManager.i3.enable = true;
    };
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gnome";
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };
}
