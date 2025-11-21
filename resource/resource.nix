{ userName, ... }:
{
  systemd.user.tmpfiles.users.${userName}.rules = [
    # firefox
    "L+ %h/.mozilla/firefox/profiles.ini 0755 ${userName} users - ${./firefox/profiles.ini}"
    "L+ %h/.mozilla/firefox/default/user.js 0755 ${userName} users - ${./firefox/user.js}"
    "L+ %h/.mozilla/firefox/default/chrome/userChrome.css 0755 ${userName} users - ${./firefox/userChrome.css}"
    "L+ %h/.mozilla/firefox/default/chrome/userContent.css 0755 ${userName} users - ${./firefox/userContent.css}"

    # desktop
    "L+ %h/.config/niri/config.kdl 0644 ${userName} users - ${./.niri.kdl}"
    "L+ %h/.config/foot/foot.ini 0755 ${userName} users - ${./.foot.ini}"
    "L+ %h/.wezterm.lua 0755 ${userName} users - ${./.wezterm.lua}"
    "L+ %h/.config/noctalia/settings.json 0755 ${userName} users - ${./.noctalia.json}"
  ];
}
