{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    preservation.url = "github:nix-community/preservation";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      userName = "saya";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        Gamma = nixpkgs.lib.nixosSystem {
          modules = [
            ./modules/modules.nix
            ./resource/resource.nix
            ./software/software.nix
            ./configuration.nix
            ./hardware.nix
          ];
          specialArgs = { inherit inputs userName; };
        };
      };
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;
    };
}
