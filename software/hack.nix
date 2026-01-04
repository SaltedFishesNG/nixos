{ pkgs, userName, ... }:
{
  environment.systemPackages = with pkgs; [
    wireshark
    (cutter.withPlugins (ps: with ps; [ jsdec rz-ghidra sigdb ]))
    (proxmark3.override { withGui = false; hardwarePlatform = "PM3GENERIC"; })
  ];

  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
    dumpcap.enable = true;
  };

  users.users.${userName}.extraGroups = [ "wireshark" ];
}
