{ pkgs, lib, ... }:
{
  services.v2raya = {
    enable = true;
    cliPackage = pkgs.xray;
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  services.sing-box = {
    enable = true;
    settings = {
      log = {
        level = "info";
        timestamp = true;
      };

      inbounds = [
        {
          type = "tun";
          tag = "tun-in";
          interface_name = "singbox_tun";
          address = [
            "172.19.0.1/30"
            "fdfe:dcba:9876::1/126"
          ];
          mtu = 9000;
          auto_route = true;
          strict_route = true;
          stack = "gvisor";
        }
      ];

      outbounds = [
        {
          type = "socks";
          tag = "proxy";
          server = "127.0.0.1";
          server_port = 1024;
          version = "5";
        }
        {
          type = "direct";
          tag = "direct";
        }
      ];

      route = {
        auto_detect_interface = true;
        rules = [
          {
            outbound = "direct";
            process_name = [
              ".xray-wrapped"
              ".v2rayA-wrapped"
            ];
          }
          {
            outbound = "direct";
            ip_is_private = true;
          }
          {
            outbound = "direct";
            rule_set = [ "geosite-private" ];
          }
          { outbound = "proxy"; }
        ];
        rule_set = [
          {
            tag = "geosite-private";
            type = "local";
            format = "binary";
            path = "${pkgs.sing-geosite}/share/sing-box/rule-set/geosite-private.srs";
          }
        ];
        final = "proxy";
      };
    };
  };

  systemd.services.sing-box.wantedBy = lib.mkForce [ ];
}
