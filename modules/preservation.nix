{ userName, inputs, ... }:
{
  imports = [ inputs.preservation.nixosModules.preservation ];

  preservation = {
    enable = true;
    preserveAt."/persist" = {
      files = [ ];
      directories = [ ];
      users.${userName} = {
        files = [ ".local/share/fish/fish_history" ];
        directories = [
          "Projects"
          {
            directory = ".ssh";
            mode = "0700";
          }
        ];
      };
    };
  };
}
