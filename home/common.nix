{
  config,
  lib,
  settings,
  repoPath,
  ...
}:
let
  s = settings;

  dotfilesPath = "${repoPath}/dotfiles";
  dirContents = builtins.readDir ../dotfiles;
  mkMutableEntry = name: _: {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${name}";
  };

in
{
  home.pointerCursor = {
    enable = true;
    name = s.cursor.name;
    gtk.enable = true;
    package = s.cursor.package;
    size = s.cursor.size;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = s.gtkTheme.name;
      package = s.gtkTheme.package;
    };
    gtk4.theme = {
      name = s.gtkTheme.name;
      package = s.gtkTheme.package;
    };
    gtk3.extraConfig = {
      gtk-enable-animations = s.animations;
      gtk-primary-button-warps-slider = false;
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-enable-animations = s.animations;
      gtk-primary-button-warps-slider = false;
      gtk-application-prefer-dark-theme = true;
      gtk-hint-font-metrics = true;
    };
    iconTheme = {
      name = s.iconTheme.name;
      package = s.iconTheme.package;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = s.gtkTheme.name;
      color-scheme = "prefer-dark";
      cursor-theme = s.cursor.name;
      cursor-size = s.cursor.size;
      icon-theme = s.iconTheme.name;
    };
  };

  xdg.configFile = lib.mapAttrs mkMutableEntry dirContents;
}
