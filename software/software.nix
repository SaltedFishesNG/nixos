{ pkgs, ... }:
{
  imports = [
    ./basic.nix
    ./desktop.nix
    ./fcitx5.nix
    ./font.nix
    ./game.nix
    ./hack.nix
    ./proxy.nix
    ./UNFREE.nix
    ./virtualisation.nix
  ];

  environment.systemPackages = with pkgs; [
    appimage-run
    file
    git
    gnupg
    ncdu
    nh
    nix-output-monitor
    p7zip
    steam-run-free
    tree
    unrar-free
    unzip
    wget
    zip
  ];

  programs = {
    firefox.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
    htop = {
      enable = true;
      settings = {
        color_scheme = 6;
        hide_userland_threads = true;
        highlight_base_name = true;
        highlight_changes = true;
        shadow_other_users = true;
        show_cpu_temperature = true;
        show_program_path = false;
        tree_view = true;
      };
    };
    vim = {
      enable = true;
      package = pkgs.vim-full;
    };
  };
}
