{
  settings,
  theme,
  ...
}:
let
  s = settings;
  t = theme;

  css = ''
    @define-color window_bg_color ${t.surface};
    @define-color window_fg_color ${t.fg};
    @define-color view_bg_color ${t.bg};
    @define-color view_fg_color ${t.fg};
    @define-color headerbar_bg_color ${t.surface};
    @define-color headerbar_fg_color ${t.fg};
    @define-color sidebar_bg_color ${t.surface};
    @define-color sidebar_fg_color ${t.fg};
    @define-color popover_bg_color ${t.hover};
    @define-color popover_fg_color ${t.fg};
    @define-color dialog_bg_color ${t.hover};
    @define-color dialog_fg_color ${t.fg};
    @define-color card_bg_color ${t.hover};
    @define-color card_fg_color ${t.fg};
    @define-color accent_bg_color ${t.accent};
    @define-color accent_fg_color ${t.contrast};
    @define-color accent_color ${t.accent};
    @define-color destructive_bg_color ${t.red};
    @define-color destructive_fg_color ${t.contrast};
    @define-color destructive_color ${t.red};
    @define-color success_bg_color ${t.green};
    @define-color success_fg_color ${t.contrast};
    @define-color success_color ${t.green};
    @define-color warning_bg_color ${t.yellow};
    @define-color warning_fg_color ${t.contrast};
    @define-color warning_color ${t.yellow};
    @define-color error_bg_color ${t.red};
    @define-color error_fg_color ${t.contrast};
    @define-color error_color ${t.red};
  '';
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
    gtk3.extraCss = css;
    gtk4.extraCss = css;
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
}
