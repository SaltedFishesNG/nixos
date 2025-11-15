{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    {
      system = "x86_64-linux";
      nixosConfigurations."Gamma" = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules/modules.nix
          ./software/software.nix
          ./user/saya.nix
          ./configuration.nix
          ./hardware-configuration.nix
        ];
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
