{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # ./software/desktop.nix
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    userName = "saya";
  in
  {
    system = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ];
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
