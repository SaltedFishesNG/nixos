{ pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./fcitx5.nix
    ./font.nix
  ];

  environment.systemPackages = with pkgs; [
    file
    gnupg
    p7zip
    tree
    unzip
    wget
    zip
  ];

  programs = {
    firefox.enable = true;
    git.enable = true;
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
    vim = {
      enable = true;
      package = pkgs.vim-full;
    };
  };
}
