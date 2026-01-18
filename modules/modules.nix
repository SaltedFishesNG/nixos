{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./lanzaboote.nix
    ./nixvim.nix
    ./preservation.nix
  ];
}
