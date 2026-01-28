{ pkgs, ... }:
{
  imports = [
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
    mpv
    qbittorrent
    tor-browser
    zed-editor

    android-tools
    appimage-run
    dnsutils
    file
    gnupg
    lsof
    ncdu
    nh
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
      config = {
        user.name = "SaltedFishes";
        user.email = "main@saltedfishes.com";
        http.proxy = "socks5://localhost:1024";
        https.proxy = "socks5://localhost:1024";
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
        hide_userland_threads = true;
        highlight_base_name = true;
        highlight_changes = true;
        shadow_other_users = true;
        show_cpu_temperature = true;
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

  services.flatpak.enable = true;
}
