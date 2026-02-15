{
  description = "Until dandelions spread across the desert...";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    preservation.url = "github:nix-community/preservation";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      userName = "saya";
    in
    {
      nixosConfigurations.Gamma = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules/disko.nix
          ./modules/preservation.nix
          ./resource/resource.nix
          ./software/software.nix
          ./configuration.nix
          ./hardware.nix
        ];
        specialArgs = { inherit inputs userName; };
      };
    };
}
