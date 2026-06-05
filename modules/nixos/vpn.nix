{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.vpn;

  ip = "${pkgs.iproute2}/bin/ip";
  table = "200";
  mark = "0xff"; # must match streamSettings.sockopt.mark in /etc/xray/config.json

  routeUp = pkgs.writeShellScript "xray-route-up" ''
    set -eu
    for _ in $(seq 1 50); do
      ${ip} link show xray0 >/dev/null 2>&1 && break
      sleep 0.1
    done
    ${ip} rule add fwmark ${mark} lookup main priority 100
    ${ip} rule add lookup ${table} priority 200
    ${ip} route replace default dev xray0 table ${table}
  '';

  routeDown = pkgs.writeShellScript "xray-route-down" ''
    ${ip} rule del priority 200 2>/dev/null || true
    ${ip} rule del priority 150 2>/dev/null || true
    ${ip} rule del priority 100 2>/dev/null || true
    ${ip} route flush table ${table} 2>/dev/null || true
  '';
in
{
  options.modules.vpn.enable = lib.mkEnableOption "Xray (native tun) VPN client";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.xray ];

    # Secret config lives out-of-store at /etc/xray/config.json
    systemd.services.xray = {
      description = "Xray VPN (tun)";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        ExecStartPre = "+${routeDown}"; # clear any leftovers from a crashed run
        ExecStart = "${pkgs.xray}/bin/xray run -c /etc/xray/config.json";
        ExecStartPost = "+${routeUp}";
        ExecStopPost = "+${routeDown}";
        AmbientCapabilities = [ "CAP_NET_ADMIN" ];
        CapabilityBoundingSet = [ "CAP_NET_ADMIN" ];
        Restart = "on-failure";
        RestartSec = 3;
      };
    };
  };
}
