{ modulesPath, ... }:
{
  nixpkgs.hostPlatform = "x86_64-linux";

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot = {
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "riscv64-linux"
    ];
    kernelParams = [ ];
    initrd.availableKernelModules = [
      "ahci"
      "rtsx_usb_sdmmc"
      "sd_mod"
      "xhci_pci"
    ];
    kernelModules = [ "kvm-intel" ];
    blacklistedKernelModules = [ "nouveau" ];
  };
  hardware = {
    cpu.intel.updateMicrocode = true;
    cpu.intel.sgx.provision.enable = true;
    graphics.enable = true;
    nvidia.open = false;
  };
  services.xserver.videoDrivers = [
    "modesetting"
    "fbdev"
    "nvidia"
  ];
  # services.aesmd.enable = true;
}
