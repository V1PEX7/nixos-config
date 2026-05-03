{ config, lib, ... }:
let
  cfg = config.modules.hardening.network;
in
{
  options.modules.hardening.network.enable = lib.mkEnableOption "network sysctl hardening";

  config = lib.mkIf cfg.enable {
    networking.tempAddresses = "enabled";

    boot.kernel.sysctl = {
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;

      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;

      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv4.conf.default.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.default.accept_source_route" = 0;

      "net.ipv4.conf.all.log_martians" = 1;
      "net.ipv4.conf.default.log_martians" = 1;

      "net.ipv4.tcp_syncookies" = 1;
      "net.ipv4.tcp_syn_retries" = 3;
      "net.ipv4.tcp_synack_retries" = 2;

      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    };
  };
}
