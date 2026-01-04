{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    file
    tree
    wget
  ];

  programs = {
    git.enable = true;
    htop = {
      enable = true;
      settings = {
        show_program_path = false;
        tree_view = true;
      };
    };
    mtr.enable = true;
  };
}
