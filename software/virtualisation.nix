{
  config,
  lib,
  pkgs,
  userName,
  ...
}:
{
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
      onShutdown = "shutdown";
    };
  };
  users.users.${userName}.extraGroups = [
    "kvm"
    "libvirtd"
  ];

  environment.systemPackages = with pkgs; [
    virglrenderer
  ];
  programs.virt-manager.enable = true;

  networking.firewall.trustedInterfaces = lib.mkIf config.networking.nftables.enable [ "virbr0" ];
}
