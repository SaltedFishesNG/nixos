{ userName, inputs, ... }:
{
  imports = [ inputs.preservation.nixosModules.preservation ];

  preservation = {
    enable = true;
    preserveAt."/persist" = {
      files = [ ];
      directories = [
        "/etc/v2raya"
        "/var/lib/archisteamfarm"
        "/var/lib/bluetooth"
        "/var/lib/iwd"
        "/var/lib/libvirt"
      ];
      users.${userName} = {
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
          ".mozilla/firefox/default"
          ".thunderbird/default"

          # Game
          ".local/share/PrismLauncher"
          ".local/share/Steam"
          ".steam"
        ];
      };
      users.root.directories = [ ".local/share/xray" ];
    };
  };
}
