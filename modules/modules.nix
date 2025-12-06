{ userName, ... }:
{
  imports = [
    ./preservation/module.nix # https://github.com/nix-community/preservation
  ];

  preservation = {
    enable = true;
    preserveAt."/persist" = {
      files = [ ];
      directories = [ "/var/lib/iwd" ];
      users.${userName} = {
        files = [ ];
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
          ".mozilla/firefox"
        ];
      };
    };
  };
}
