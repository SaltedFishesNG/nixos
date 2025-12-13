{ pkgs, userName, ... }:
{
  systemd.user.tmpfiles.users.${userName}.rules = [
    "L+ %h/.icons/default               - ${userName} users - ${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice"

    "L+ %h/.config/fuzzel/fuzzel.ini    - ${userName} users - ${./.fuzzel.ini}"
    "L+ %h/.config/mako/config          - ${userName} users - ${./.mako.ini}"
    "L+ %h/.config/niri/bg.png          - ${userName} users - ${./niri/bg.png}"
    "L+ %h/.config/niri/config.kdl      - ${userName} users - ${./niri/niri.kdl}"
    "L+ %h/.config/niri/lock.png        - ${userName} users - ${./niri/lock.png}"
    "L+ %h/.config/niri/swaydle.sh      - ${userName} users - ${./niri/swaydle.sh}"
    "L+ %h/.config/waybar/config.jsonc  - ${userName} users - ${./waybar/config.jsonc}"
    "L+ %h/.config/waybar/style.css     - ${userName} users - ${./waybar/style.css}"

    "L+ %h/.config/foot/foot.ini        - ${userName} users - ${./.foot.ini}"
    "L+ %h/.thunderbird/profiles.ini    - ${userName} users - ${./firefox/profiles.ini}"
    "L+ %h/.wezterm.lua                 - ${userName} users - ${./.wezterm.lua}"

    # firefox
    "L+ %h/.mozilla/firefox/default/chrome/userChrome.css  - ${userName} users - ${./firefox/userChrome.css}"
    "L+ %h/.mozilla/firefox/default/chrome/userContent.css - ${userName} users - ${./firefox/userContent.css}"
    "L+ %h/.mozilla/firefox/default/user.js                - ${userName} users - ${./firefox/user.js}"
    "L+ %h/.mozilla/firefox/profiles.ini                   - ${userName} users - ${./firefox/profiles.ini}"
  ];
}
