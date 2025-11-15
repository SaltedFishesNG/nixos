{ pkgs, lib, ... }:
{
  imports = [
    ./desktop.nix
    # ./dev.nix
    ./fcitx5.nix
    ./firefox.nix
    ./font.nix
    ./game.nix
    ./nvidia.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    (pkgs.callPackage ./proxmark3.nix { })
  ]
  ++ lib.attrValues {
    inherit (pkgs)
      # GUI
      v2rayn
      vlc
      zed-editor

      # CLI
      gnupg
      htop
      p7zip
      qrencode
      unrar
      unzip
      uv
      vim
      wget
      whois
      zip
      ;
  };

  programs.gnupg.agent.enable = true;

  programs.git = {
    enable = true;
    config = [
      {
        user = {
          name = "SaltedFishes";
          email = "main@saltedfishes.com";
        };
      }
    ];
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_color_command blue
    '';
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/persist/home/saya/Projects/nixos";
  };
}
