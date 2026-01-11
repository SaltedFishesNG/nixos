{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "rtsx_usb_sdmmc"
      "sd_mod"
      "xhci_pci"
    ];
    kernelModules = [ "kvm-intel" ];
    initrd.kernelModules = [ ];
    extraModulePackages = [ ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.nvidia.open = false;
  services.xserver.videoDrivers = [ "nvidia" ];
}
