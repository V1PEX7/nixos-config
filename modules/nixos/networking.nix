{ config, lib, ... }:
let
  cfg = config.modules.networking;
in
{
  options.modules.networking.enable = lib.mkEnableOption "networking configuration";

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = lib.mkDefault false;

    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNS = "9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net 2620:fe::fe#dns.quad9.net 2620:fe::9#dns.quad9.net";
        DNSOverTLS = "true";
        DNSSEC = "true";
        Domains = [ "~." ];
        FallbackDNS = "";
      };
    };

    networking.firewall = {
      enable = true;
      allowPing = false;
      checkReversePath = "loose";
      trustedInterfaces = [ "tun0" ];
    };
  };
}
