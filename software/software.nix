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
    zed-editor

    # CLI
    dnsutils
    file
    gnupg
    ncdu
    p7zip
    qrencode
    steam-run-free
    tree
    unrar-free
    unzip
    wget
    whois
    zip
    (callPackage ./_pkgs/proxmark3.nix { })
  ];

  programs = {
    firefox.enable = true;
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
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
    htop = {
      enable = true;
      settings = {
        show_program_path = false;
        tree_view = true;
      };
    };
    mtr.enable = true;
    thunderbird.enable = true;
    vim = {
      enable = true;
      package = pkgs.vim-full;
    };
  };

  services.v2raya = {
    enable = true;
    cliPackage = pkgs.xray;
  };

  users.users.${userName} = {
    extraGroups = [ ];
    shell = pkgs.fish;
  };
}
