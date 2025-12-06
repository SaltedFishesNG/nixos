{ pkgs, ... }:
{
  imports = [
    ./desktop.nix
    # ./fcitx5.nix
  ];

  environment.systemPackages = with pkgs; [
    firefox
    git
    p7zip
    qrencode
    unrar-free
    unzip
    vim
    wget
    zip
  ];
}
