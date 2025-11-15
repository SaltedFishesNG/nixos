{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      fira-code
      font-awesome
      iosevka
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      sarasa-gothic
    ];
    fontconfig.defaultFonts = pkgs.lib.mkForce {
      serif = [
        "Noto Serif"
        "Noto Serif CJK TC"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Sans CJK TC"
      ];
      monospace = [
        "Fira Code"
        "Noto Sans Mono CJK TC"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
