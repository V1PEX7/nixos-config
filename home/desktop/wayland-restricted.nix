{ pkgs, ... }:
let
  wlSecurityContext = import ../../lib/wl-security-context.nix { inherit pkgs; };
in
{
  systemd.user.services.wayland-restricted = {
    Unit = {
      Description = "Restricted Wayland socket for untrusted clients";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${wlSecurityContext}/bin/wl-security-context %t/wayland-restricted untrusted";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
