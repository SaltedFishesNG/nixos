{ pkgs, userName, ... }:
{
  environment.systemPackages = with pkgs; [
    aircrack-ng
    (cutter.withPlugins (
      ps: with ps; [
        jsdec
        rz-ghidra
        sigdb
      ]
    ))
    (proxmark3.override {
      withGui = false;
      hardwarePlatform = "PM3GENERIC";
    })
    wireshark
  ];

  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
    dumpcap.enable = true;
  };

  users.users.${userName}.extraGroups = [ "wireshark" ];
}
