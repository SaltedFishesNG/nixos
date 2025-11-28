{ pkgs, userName, ... }:
{
  systemd.user.tmpfiles.users.${userName}.rules = [
    # desktop
    "L+ %h/.config/waybar/config.jsonc 0755 ${userName} users - ${./desktop/waybar/config.jsonc}"
    "L+ %h/.config/waybar/style.css 0755 ${userName} users - ${./desktop/waybar/style.css}"
    "L+ %h/.config/foot/foot.ini 0755 ${userName} users - ${./desktop/foot.ini}"
    "L+ %h/.config/niri/config.kdl 0644 ${userName} users - ${./desktop/niri.kdl}"
    "L+ %h/.wezterm.lua 0755 ${userName} users - ${./desktop/wezterm.lua}"

    "L+ %h/.icons/default 0755 ${userName} users - ${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice"

    # firefox
    "L+ %h/.mozilla/firefox/profiles.ini 0755 ${userName} users - ${./firefox/profiles.ini}"
    "L+ %h/.mozilla/firefox/default/user.js 0755 ${userName} users - ${./firefox/user.js}"
    "L+ %h/.mozilla/firefox/default/chrome/userChrome.css 0755 ${userName} users - ${./firefox/userChrome.css}"
    "L+ %h/.mozilla/firefox/default/chrome/userContent.css 0755 ${userName} users - ${./firefox/userContent.css}"
  ];
}
