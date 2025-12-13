{ pkgs, userName, ... }:
{
  imports = [
    ./desktop.nix
    ./fcitx5.nix
    ./game.nix
    ./UNFREE.nix
    ./virtualisation.nix
  ];

  environment.systemPackages = with pkgs; [
    # GUI
    obs-studio
    v2rayn
    zed-editor

    # CLI
    appimage-run
    file
    gnupg
    mtr
    p7zip
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
      shellInit = "set fish_color_command blue";
    };
    git = {
      enable = true;
      config.user = {
        name = "SaltedFishes";
        email = "main@saltedfishes.com";
      };
    };
    gnupg.agent.enable = true;
    htop = {
      enable = true;
      settings = {
        show_program_path = false;
        tree_view = true;
      };
    };
    thunderbird.enable = true;
    vim = {
      enable = true;
      package = pkgs.vim-full;
    };
  };

  users.users.${userName}.shell = pkgs.fish;
}
