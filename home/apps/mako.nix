{
  lib,
  pkgs,
  theme,
  settings,
  ...
}:
let
  t = theme;
  s = settings;
in
{
  services.mako = {
    enable = true;

    settings = {
      font = "${s.font.familyPropo} ${toString s.font.size}";
      layer = "overlay";

      width = 320;
      height = 110;
      margin = s.gaps_out;
      padding = 12;

      background-color = t.bg;
      text-color = t.fg;
      border-color = t.accent;
      border-size = s.border_size;
      border-radius = s.rounding;
      progress-color = "over ${t.hover}";

      icon-path = "${s.iconTheme.package}/share/icons/${s.iconTheme.name}";
      max-icon-size = 48;

      default-timeout = 5000;
      group-by = "app-name";

      "urgency=low" = {
        border-color = t.hover;
      };

      "urgency=critical" = {
        border-color = t.red;
        default-timeout = 0;
      };
    };
  };

  systemd.user.services.mako = {
    Unit = {
      Description = "Lightweight Wayland notification daemon";
      Documentation = "man:mako(1)";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = lib.getExe pkgs.mako;
      ExecReload = "${lib.getExe' pkgs.mako "makoctl"} reload";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
