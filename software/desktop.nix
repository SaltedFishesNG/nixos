{ pkgs, lib, ... }:
{
  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      alacritty
      fuzzel
      waybar
      xwayland-satellite
      ;
  };
  programs.niri.enable = true;
}
