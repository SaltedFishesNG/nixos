{ userName, inputs, ... }:
{
  imports = [ inputs.preservation.nixosModules.preservation ];

  preservation = {
    enable = true;
    preserveAt."/persist" = {
      files = [
        # { file = "/etc/ssh/ssh_host_ed25519_key"; mode = "0600"; }
        # { file = "/etc/ssh/ssh_host_ed25519_key.pub"; mode = "0644"; }
        # { file = "/etc/ssh/ssh_host_rsa_key"; mode = "0600"; }
        # { file = "/etc/ssh/ssh_host_rsa_key.pub"; mode = "0644"; }
      ];
      directories = [ ];
      users.${userName} = {
        files = [ ".local/share/fish/fish_history" ];
        directories = [
          "Projects"
          { directory = ".ssh"; mode = "0700"; }
        ];
      };
    };
  };
}
