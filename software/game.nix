{ pkgs, lib, ... }:
{
  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      # alcom
      prismlauncher
      ;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
