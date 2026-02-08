{ modulesPath, ... }:
{
  nixpkgs.hostPlatform = "x86_64-linux";

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  virtualisation.virtualbox.guest.enable = true;
}
