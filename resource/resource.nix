{ pkgs, userName, ... }:
{
  systemd.user.tmpfiles.users.${userName}.rules = [
    # desktop
    "L+ %h/.config/waybar/config.jsonc 0755 ${userName} users - ${./waybar/config.jsonc}"
    "L+ %h/.config/waybar/style.css 0755 ${userName} users - ${./waybar/style.css}"
    "L+ %h/.config/foot/foot.ini 0755 ${userName} users - ${./.foot.ini}"
    "L+ %h/.config/mako/config 0644 ${userName} users - ${./.mako.ini}"
    "L+ %h/.config/niri/config.kdl 0644 ${userName} users - ${./.niri.kdl}"

    "L+ %h/.icons/default 0755 ${userName} users - ${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice"
  ];
}
