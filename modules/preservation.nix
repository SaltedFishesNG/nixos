{ userName, inputs, ... }:
{
  imports = [ inputs.preservation.nixosModules.preservation ];

  preservation = {
    enable = true;
    preserveAt."/persist" = {
      files = [ ];
      directories = [
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

          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          ".config/zed"
          ".local/share/v2rayN"
          ".local/share/zed"
          ".mozilla/firefox/default"
          ".thunderbird/default"

          # Game
          ".local/share/PrismLauncher"
          # ".local/share/ALCOM"
          # ".local/share/VRChatCreatorCompanion"
          ".local/share/Steam"
          ".steam"
        ];
      };
    };
  };
}
