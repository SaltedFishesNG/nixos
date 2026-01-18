{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
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
        Image = nixpkgs.lib.nixosSystem {
          modules = [
            ./modules/modules.nix
            ./platform/Image.nix
            ./configuration.nix
          ];
          specialArgs = { inherit inputs userName system; };
        };
        iso = nixpkgs.lib.nixosSystem {
          modules = [
            ./platform/iso.nix
            ./resource/resource.nix
            ./software/software.nix
            ./configuration.nix
          ];
          specialArgs = { inherit inputs userName system; };
        };
      };
      packages.${system} = {
        diskoImage = inputs.self.nixosConfigurations.Image.config.system.build.diskoImages;
        iso = inputs.self.nixosConfigurations.iso.config.system.build.images.iso;
      };
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;
    };
}
