{ pkgs, userName, ... }:
{
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
        nv_powermizer_mode = 1;
      };
    };
    enableRenice = true;
  };

  services.archisteamfarm = {
    enable = false;
    web-ui.enable = true;
  };

  users.users.${userName}.extraGroups = [ "gamemode" ];
}
