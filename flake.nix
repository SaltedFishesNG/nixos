{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
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
