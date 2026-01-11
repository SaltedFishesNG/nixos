{ pkgs, userName, ... }:
{
  imports = [
    ./desktop.nix
    ./fcitx5.nix
    ./game.nix
    ./proxy.nix
    # ./hack.nix
    ./UNFREE.nix
    ./virtualisation.nix
  ];

  environment.systemPackages = with pkgs; [
    mpv

    dnsutils
    file
    gnupg
    ncdu
    p7zip
    qrencode
    rdap
    steam-run-free
    tree
    unrar-free
    unzip
    wget
    whois
    zip
  ];

  programs = {
    firefox.enable = true;
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
}
