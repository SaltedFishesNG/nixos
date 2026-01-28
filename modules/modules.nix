{ inputs, system, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./preservation.nix
  ];

  disko.imageBuilder = {
    enableBinfmt = true;
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    kernelPackages = inputs.nixpkgs.legacyPackages.${system}.linuxPackages_latest;
  };
}
