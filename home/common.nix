{
  config,
  lib,
  pkgs,
  ...
}:
let
  dotfilesPath = "${config.home.homeDirectory}/nixos-config/dotfiles";
  localDotfilesPath = ../dotfiles;
  dirContents =
    if builtins.pathExists localDotfilesPath then builtins.readDir localDotfilesPath else { };
  mkMutableEntry = name: _: {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${name}";
  };

  GTK_THEME_NAME = "Graphite-Dark";
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

  home.sessionVariables = {
    GTK_THEME = GTK_THEME_NAME;
    XDG_DATA_DIRS = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS";
  };

  gtk = {
    enable = true;
    theme = {
      name = GTK_THEME_NAME;
      package = pkgs.graphite-gtk-theme.override {
        themeVariants = [ ];
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        tweaks = [
          "rimless"
          "darker"
        ];
      };
    };
    gtk4.theme = {
      name = GTK_THEME_NAME;
      package = pkgs.graphite-gtk-theme.override {
        themeVariants = [ ];
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        tweaks = [
          "rimless"
          "darker"
        ];
      };
    };
    gtk3.extraConfig = {
      gtk-enable-animations = true;
      gtk-primary-button-warps-slider = false;
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-enable-animations = true;
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
