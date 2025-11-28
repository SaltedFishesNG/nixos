{ userName, ... }:
{
  imports = [
    ./preservation/module.nix # https://github.com/nix-community/preservation
  ];

  preservation = {
    enable = true;
    preserveAt."/persist" = {
      files = [ ];
      directories = [
        "/var/lib/iwd"
      ];
      users.${userName} = {
        files = [
          ".local/share/fish/fish_history"
        ];
        directories = [
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Projects"

          {
            directory = ".ssh";
            mode = "0700";
          }
          {
            directory = ".gnupg";
            mode = "0700";
          }
          ".mozilla/firefox/default"
          ".config/Signal"
          ".config/zed"
          ".local/share/zed"
          ".local/share/v2rayN"

          # Game
          ".local/share/ALCOM"
          ".local/share/VRChatCreatorCompanion"
          ".local/share/PrismLauncher"
          ".local/share/Steam"
          ".steam"
        ];
      };
    };
  };

}
