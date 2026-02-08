{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/v1.0.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
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
          inputs.disko.nixosModules.disko
          ./modules/disko.nix
          ./modules/lanzaboote.nix
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
