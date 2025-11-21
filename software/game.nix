{ pkgs, lib, ... }:
{
  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      alcom
      adwsteamgtk
      prismlauncher
      ;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
