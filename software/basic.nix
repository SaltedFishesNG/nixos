{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ladybird
    libreoffice
    mpv
    qbittorrent
    tor-browser
    zed-editor

    android-tools
    dnsutils
    lsof
    qrencode
    rdap
    whois
  ];

  programs = {
    git = {
      enable = true;
      config = {
        commit.gpgSign = true;
        core.autocrlf = "input";
        http.proxy = "socks5://localhost:1024";
        https.proxy = "socks5://localhost:1024";
        merge.autoStash = true;
        pull.autoStash = true;
        # pull.rebase = true;
        rebase.autoStash = true;
        safe.directory = "*";
        tag.gpgSign = true;
        user.email = "main@saltedfishes.com";
        user.name = "SaltedFishes";
        user.signingkey = "0F3659EAC9207CE3B0D7C5ABA4CA90D326E9FB7C";
      };
    };
    mtr.enable = true;
    thunderbird.enable = true;
  };

  services.flatpak.enable = true;
}
