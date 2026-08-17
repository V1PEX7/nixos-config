{
  config,
  lib,
  pkgs,
  ...
}:
let
  cur = config.home.pointerCursor;

  # Preloaded by uwsm into the graphical session
  graphical = {
    GTK_THEME = config.gtk.theme.name;
    XDG_DATA_DIRS = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS";
    XCURSOR_PATH = "$HOME/.icons:$HOME/.local/share/icons:/run/current-system/sw/share/icons";
    XCURSOR_THEME = cur.name;
    XCURSOR_SIZE = toString cur.size;
    HYPRCURSOR_THEME = cur.name;
    HYPRCURSOR_SIZE = toString cur.size;

    TERMINAL = "foot";

    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    NIXOS_OZONE_WL = "1";
  };
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";

    PYTHONPYCACHEPREFIX = "${config.xdg.cacheHome}/python";
    LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
  };

  xdg.configFile."uwsm/env".text = lib.concatLines (
    lib.mapAttrsToList (name: value: ''export ${name}="${value}"'') graphical
  );
}
