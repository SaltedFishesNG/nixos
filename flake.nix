{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    preservation.url = "github:nix-community/preservation";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    userName = "saya";
    lib = nixpkgs.lib;
  in rec
  {
    nixosConfigurations.Image = lib.nixosSystem {
      modules = [
        ./modules/disko.nix
        ./modules/preservation.nix
        ./software/software.nix
        ./configuration.nix
        ./hardware-configuration.nix
      ];
      specialArgs = { inherit inputs userName; };
    };
    packages.x86_64-linux = {
      image = self.nixosConfigurations.Image.config.system.build.diskoImages;
    };
  };
}
