{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, disko, ... }:
  let
    userName = "saya";
  in
  {
    nixosConfigurations.Gamma = nixpkgs.lib.nixosSystem {
      modules = [
        disko.nixosModules.disko
        ./modules/modules.nix
        ./resource/resource.nix
        ./software/software.nix
        ./configuration.nix
        ./disk-config.nix
        ./hardware-configuration.nix
      ];
      specialArgs = { inherit inputs userName; };
    };
  };
}
