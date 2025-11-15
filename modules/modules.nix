{
  imports = [
    ./preservation/module.nix
  ];

  preservation = {
    enable = true;
    preserveAt."/persist" = {
      files = [ ];
      directories = [ ];
      users.saya = {
        files = [
          ".local/share/fish/fish_history"
        ];
        directories = [
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Projects"
          ".config/zed"
          ".local/share/PrismLauncher"
          ".local/share/Steam"
          ".local/share/v2rayN"
          ".local/share/zed"
          ".mozilla"
          ".steam"
          {
            directory = ".ssh";
            mode = "0700";
          }
          {
            directory = ".gnupg";
            mode = "0700";
          }
        ];
      };
    };
  };
}
