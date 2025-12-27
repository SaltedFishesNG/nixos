{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixy.url = "github:anialic/nixy";
    preservation.url = "github:nix-community/preservation";
    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, nixy, ... }:
  let
    userName = "saya";
  in
  {
    nixosConfigurations.Gamma = nixpkgs.lib.nixosSystem {
      modules = [
        ./modules/modules.nix
        ./resource/resource.nix
        ./software/software.nix
        ./configuration.nix
        ./hardware-configuration.nix
      ];
      specialArgs = { inherit inputs userName; };
    };
  };
}
