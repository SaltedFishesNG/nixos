{ inputs, userName, ... }:
{
  imports = [ inputs.preservation.nixosModules.preservation ];

  preservation.enable = true;
  preservation.preserveAt."/persist" = {
    files = [ ];
    directories = [ ];
  };
  preservation.preserveAt."/persist".users.${userName} = {
    files = [ ".local/share/fish/fish_history" ];
    directories = [
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Projects"
    ];
  };
}
