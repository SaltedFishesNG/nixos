{ pkgs, lib, config, userName, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
      onBoot = "start";
      onShutdown = "shutdown";
    };
    spiceUSBRedirection.enable = true;
    xen = {
      # /nix/store/*-xen-*/libexec/xen/bin/qemu-system-i386 => /run/current-system/sw/bin/qemu-system-i386
      enable = false;
      dom0Resources.memory = 10000;
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
