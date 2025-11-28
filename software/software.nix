{ pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./fcitx5.nix
    ./game.nix
    ./unfree.nix
    ./virtualisation.nix
  ];

  environment.systemPackages = with pkgs; [
    # GUI
    obs-studio
    signal-desktop
    v2rayn
    zed-editor

    # CLI
    gnupg
    p7zip
    parted
    qrencode
    steam-run-free
    unrar-free
    unzip
    uv
    wget
    whois
    zip
    (callPackage ./_proxmark3.nix { })
  ];

  programs = {
    firefox = {
      enable = true;
      languagePacks = [ "zh-TW" ];
    };
    fish = {
      enable = true;
      shellInit = ''
        set fish_color_command blue
      '';
    };
    git = {
      enable = true;
      config.user = {
        name = "SaltedFishes";
        email = "main@saltedfishes.com";
      };
    };
    htop = {
      enable = true;
      settings = {
        show_program_path = false;
        tree_view = true;
      };
    };
    vim = {
      enable = true;
      package = pkgs.vim-full;
    };
    gnupg.agent.enable = true;
  };
}
