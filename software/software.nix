{ pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./fcitx5.nix
    ./font.nix
    ./game.nix
    ./proxy.nix
    # ./hack.nix
    ./UNFREE.nix
    ./virtualisation.nix
  ];

  environment.systemPackages = with pkgs; [
    mpv

    android-tools
    dnsutils
    file
    gnupg
    ncdu
    nix-output-monitor
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
        color_scheme = 6;
        tree_view = true;
        all_branches_collapsed = true;
        show_program_path = false;
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
