{
  config,
  lib,
  pkgs,
  theme,
  settings,
  repoPath,
  ...
}:
let
  t = theme;
  s = settings;

  dotfilesPath = "${repoPath}/dotfiles";
  localDotfilesPath = ../dotfiles;
  dirContents =
    if builtins.pathExists localDotfilesPath then builtins.readDir localDotfilesPath else { };
  mkMutableEntry = name: _: {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${name}";
  };

  GTK_THEME_NAME = "adw-gtk3-dark";
  GTK_CURSOR_NAME = "Bibata-Modern-Classic";
in
{
  home.pointerCursor = {
    enable = true;
    name = GTK_CURSOR_NAME;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    size = 20;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = GTK_THEME_NAME;
      package = pkgs.adw-gtk3;
    };
    gtk4.theme = {
      name = GTK_THEME_NAME;
      package = pkgs.adw-gtk3;
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
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = GTK_THEME_NAME;
      color-scheme = "prefer-dark";
      cursor-theme = GTK_CURSOR_NAME;
      cursor-size = 20;
      icon-theme = "Papirus-Dark";
    };
  };

  xdg.configFile = lib.mapAttrs mkMutableEntry dirContents;
}
