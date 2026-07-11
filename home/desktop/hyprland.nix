{
  pkgs,
  osConfig,
  lib,
  ...
}:
let
  t = import ../theme.nix;
  isDesktop = osConfig.networking.hostName == "desktop";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      "exec-once" = [
        "bash ~/.config/hypr/autostart.sh"
        "[workspace special:term silent] foot"
      ];

      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,20"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORMTHEME,gtk3"
        "QT_QPA_PLATFORM,wayland"
        "GDK_BACKEND,wayland"
        "XDG_THEME_DESKTOP_SCHEME,prefer-dark"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "NIXOS_OZONE_WL,1"
      ];

      monitor = [
        "DP-1,2560x1440@180,0x0,1,vrr,1"
        "DP-2,1920x1080@240,-1920x360,1"
        "eDP-1,2160x1440@60,auto,1"
      ];

      workspace = lib.optionals isDesktop [
        "1, monitor:DP-1"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:DP-2"
        "8, monitor:DP-2"
        "9, monitor:DP-2"
      ];

      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 1;
        "col.active_border" = t.hypr.active_border;
        "col.inactive_border" = t.hypr.inactive_border;
        allow_tearing = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        blur = {
          enabled = true;
          size = 4;
          passes = 5;
          noise = "0.02";
          brightness = 1.0;
          contrast = "0.89";
          vibrancy = "1.2";
          new_optimizations = true;
        };

        shadow = {
          enabled = true;
          range = 10;
          render_power = 3;
          color = t.hypr.shadow;
          offset = "0 5";
        };
      };

      animations = {
        enabled = false;

        bezier = [
          "snap, 0.25, 1, 0.3, 1"
        ];

        animation = [
          "windows, 1, 3, snap, popin 80%"
          "windowsOut, 1, 3, snap, popin 80%"
          "fade, 1, 2.5, snap"
          "workspaces, 1, 2, snap, fade"
          "border, 1, 8, default"
          "layers, 1, 2.5, snap, fade"
        ];
      };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle";
        numlock_by_default = true;
        repeat_rate = 25;
        repeat_delay = 600;
        follow_mouse = 1;
        accel_profile = "flat";
        sensitivity = 0;

        touchpad = {
          scroll_factor = "1.0";
        };
      };

      cursor = {
        inactive_timeout = 5;
        warp_on_change_workspace = true;
      };

      master = {
        new_status = "slave";
        mfact = "0.5";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = false;
        allow_session_lock_restore = true;
      };

      xwayland = {
        enabled = true;
      };

      ecosystem = {
        enforce_permissions = true;
      };

      permission = [
        "${pkgs.grim}/bin/grim, screencopy, allow"
        "${pkgs.wayfreeze}/bin/wayfreeze, screencopy, allow"
        "${osConfig.programs.hyprland.portalPackage}/libexec/.*, screencopy, allow"
      ];

      bind = [
        "SUPER, t, exec, foot"
        "SUPER, e, exec, thunar"
        "SUPER, w, exec, chromium"
        "SUPER, s, exec, firefox"
        "SUPER, space, exec, fuzzel"
        "SUPER, v, exec, bash -c 'cliphist list | fuzzel --dmenu | cliphist decode | wl-copy'"

        ", Print, exec, grim -g \"$(slurp)\" -t ppm - | satty -f -"
        "SUPER SHIFT, s, exec, freeze-screenshot"
        "CTRL, Print, exec, grim - | satty -f -"
        "SUPER SHIFT, t, exec, bash -c 'grim -g \"$(slurp)\" -t png - | convert - -resize 300% -sharpen 0x1 png:- | tesseract -l eng+rus stdin stdout | wl-copy && notify-send OCR Скопировано'"

        "SUPER SHIFT, w, exec, wallpicker"

        "SUPER, q, killactive"
        "SUPER, d, fullscreen, 1"
        "SUPER, f, fullscreen, 0"
        "SUPER SHIFT, f, fullscreen, 2"
        "SUPER, c, togglefloating"
        "SUPER CTRL, c, centerwindow"
        "SUPER, n, movetoworkspacesilent, special:scratch"
        "SUPER, grave, focuscurrentorlast"

        "ALT, Tab, cyclenext"

        "SUPER, h, movefocus, l"
        "SUPER, j, movefocus, d"
        "SUPER, k, movefocus, u"
        "SUPER, l, movefocus, r"
        "SUPER, left, movefocus, l"
        "SUPER, down, movefocus, d"
        "SUPER, up, movefocus, u"
        "SUPER, right, movefocus, r"
        "SUPER ALT, j, cyclenext"
        "SUPER ALT, k, cyclenext, prev"

        "SUPER CTRL, h, swapwindow, l"
        "SUPER CTRL, j, swapwindow, d"
        "SUPER CTRL, k, swapwindow, u"
        "SUPER CTRL, l, swapwindow, r"
        "SUPER CTRL, left, swapwindow, l"
        "SUPER CTRL, down, swapwindow, d"
        "SUPER CTRL, up, swapwindow, u"
        "SUPER CTRL, right, swapwindow, r"
        "SUPER CTRL ALT, j, swapnext"
        "SUPER CTRL ALT, k, swapnext, prev"

        "SUPER SHIFT, h, focusmonitor, l"
        "SUPER SHIFT, l, focusmonitor, r"
        "SUPER SHIFT, left, layoutmsg, mfact -0.05"
        "SUPER SHIFT, right, layoutmsg, mfact +0.05"
        "SUPER SHIFT, up, layoutmsg, addmaster"
        "SUPER SHIFT, down, layoutmsg, removemaster"
        "SUPER SHIFT CTRL, h, movewindow, mon:l"
        "SUPER SHIFT CTRL, l, movewindow, mon:r"
        "SUPER SHIFT CTRL, left, movewindow, mon:l"
        "SUPER SHIFT CTRL, right, movewindow, mon:r"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"

        "SUPER ALT, 1, movetoworkspace, 1"
        "SUPER ALT, 2, movetoworkspace, 2"
        "SUPER ALT, 3, movetoworkspace, 3"
        "SUPER ALT, 4, movetoworkspace, 4"
        "SUPER ALT, 5, movetoworkspace, 5"
        "SUPER ALT, 6, movetoworkspace, 6"
        "SUPER ALT, 7, movetoworkspace, 7"
        "SUPER ALT, 8, movetoworkspace, 8"
        "SUPER ALT, 9, movetoworkspace, 9"

        "SUPER SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER SHIFT, 8, movetoworkspacesilent, 8"
        "SUPER SHIFT, 9, movetoworkspacesilent, 9"

        "SUPER, Page_Up, workspace, e-1"
        "SUPER, Page_Down, workspace, e+1"
        "SUPER, u, workspace, e-1"
        "SUPER, i, workspace, e+1"
        "SUPER CTRL, Page_Up, movetoworkspace, e-1"
        "SUPER CTRL, Page_Down, movetoworkspace, e+1"
        "SUPER CTRL, u, movetoworkspace, e-1"
        "SUPER CTRL, i, movetoworkspace, e+1"
        "SUPER, BackSpace, workspace, previous"

        "SUPER, a, togglespecialworkspace, scratch"
        "SUPER, Return, togglespecialworkspace, term"

        "SUPER, minus, layoutmsg, mfact -0.05"
        "SUPER, equal, layoutmsg, mfact +0.05"

        "SUPER, z, layoutmsg, swapwithmaster"
        "SUPER ALT, space, layoutmsg, orientationcycle"

        "SUPER SHIFT, Return, submap, resize"
        "SUPER CTRL, Return, submap, move"

        "SUPER, r, exec, hyprctl reload"

        "CTRL ALT, Delete, exit"
        "SUPER SHIFT, p, exec, bash -c 'hyprctl dispatch dpms off DP-1 && hyprctl dispatch dpms off DP-2'"
      ];

      bindl = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl stop"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86MonBrightnessUp, exec, brightnessctl --class=backlight set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl --class=backlight set 10%-"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };

    extraConfig = ''
      windowrule {
        name = firefox-private-noscreenshare
        match:class = ^(firefox)$
        match:title = .*Private Browsing.*
        no_screen_share = true
      }
      windowrule {
        name = portal-gtk-float
        match:class = ^(xdg-desktop-portal-gtk)$
        float = true
      }
      windowrule {
        name = portal-gnome-float
        match:class = ^(xdg-desktop-portal-gnome)$
        float = true
      }
      windowrule {
        name = share-screen-float
        match:title = ^(Share Screen)$
        float = true
      }
      windowrule {
        name = screen-share-float
        match:title = ^(Screen Share)$
        float = true
      }
      windowrule {
        name = satty-float
        match:class = ^(com.gabm.satty)$
        float = true
      }
      windowrule {
        name = chromium-pip
        match:class = ^(chromium-browser)$
        match:title = ^(Picture-in-Picture)$
        float = true
        pin = true
      }
      windowrule {
        name = firefox-pip
        match:class = ^(firefox)$
        match:title = ^(Picture-in-Picture)$
        float = true
        pin = true
      }
      windowrule {
        name = thunar-float
        match:class = ^(thunar)$
        float = true
        size = 1000 700
      }
      windowrule {
        name = steam-float
        match:class = ^(steam)$
        float = true
      }
      windowrule {
        name = steam-main-tile
        match:class = ^(steam)$
        match:title = ^(Steam)$
        tile = true
      }
      windowrule {
        name = steam-app
        match:class = ^(steam_app_)
        workspace = 6
        immediate = true
      }

      layerrule {
        name = selection-noanim
        match:namespace = selection
        no_anim = true
      }

      submap = resize
      bind = , h, resizeactive, -40 0
      bind = , l, resizeactive, 40 0
      bind = , k, resizeactive, 0 -40
      bind = , j, resizeactive, 0 40
      bind = , left, resizeactive, -40 0
      bind = , right, resizeactive, 40 0
      bind = , up, resizeactive, 0 -40
      bind = , down, resizeactive, 0 40
      bind = , Escape, submap, reset
      bind = , Return, submap, reset
      bind = SUPER SHIFT, Return, submap, reset
      submap = reset

      submap = move
      bind = , h, moveactive, -40 0
      bind = , l, moveactive, 40 0
      bind = , k, moveactive, 0 -40
      bind = , j, moveactive, 0 40
      bind = , left, moveactive, -40 0
      bind = , right, moveactive, 40 0
      bind = , up, moveactive, 0 -40
      bind = , down, moveactive, 0 40
      bind = , c, centerwindow
      bind = , Escape, submap, reset
      bind = , Return, submap, reset
      bind = SUPER CTRL, Return, submap, reset
      submap = reset
    '';
  };

  xdg.configFile."hypr/autostart.sh".source = pkgs.writeShellScript "hypr-autostart" ''
    waybar &

    if [ -f "$HOME/.config/wallpaper" ]; then
      swaybg -i "$HOME/.config/wallpaper" -m fill &
    fi

    cliphist wipe
    wl-clip-persist --clipboard regular --reconnect-tries 0 &
    wl-paste --type text --watch cliphist store &
    QT_QPA_PLATFORM=wayland Throne &
  '';
}
