{ inputs, userName, ... }:
{
  imports = [ inputs.preservation.nixosModules.preservation ];

  preservation.enable = true;
  preservation.preserveAt."/persist" = {
    files = [ ];
    directories = [
      "/etc/v2raya"
      "/var/lib/bluetooth"
      "/var/lib/flatpak"
      "/var/lib/iwd"
      "/var/lib/libvirt"
    ];
  };
  preservation.preserveAt."/persist".users.${userName} = {
    files = [ ".local/share/fish/fish_history" ];
    directories = [
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Projects"

      {
        directory = ".gnupg";
        mode = "0700";
      }
      {
        directory = ".ssh";
        mode = "0700";
      }
      ".local/share/PrismLauncher"
      ".local/share/Steam"
      ".mozilla/firefox/default"
      ".steam"
      ".var/app" # flatpak
    ];
  };
}
