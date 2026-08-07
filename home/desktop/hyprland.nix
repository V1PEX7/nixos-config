{
  pkgs,
  osConfig,
  lib,
  theme,
  settings,
  ...
}:
let
  t = theme;
  s = settings;
  isDesktop = osConfig.networking.hostName == "desktop";

  # Helper functions to keep our declarative bindings completely concise
  # Home Manager natively translates `_args` lists into multi-argument Lua function calls.
  mkBind = key: action: {
    _args = [
      key
      (lib.generators.mkLuaInline action)
    ];
  };
  mkBindOpt = key: action: opts: {
    _args = [
      key
      (lib.generators.mkLuaInline action)
      opts
    ];
  };
  mkEnv = k: v: {
    _args = [
      k
      v
    ];
  };
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    configType = "lua";

    settings = {
      curve = [
        {
          _args = [
            "snap"
            {
              type = "bezier";
              points = [
                [
                  0.25
                  1
                ]
                [
                  0.3
                  1
                ]
              ];
            }
          ];
        }
      ];

      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 3;
          bezier = "snap";
          style = "popin 80%";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 3;
          bezier = "snap";
          style = "popin 80%";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 2.5;
          bezier = "snap";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 2;
          bezier = "snap";
          style = "slide";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 8;
          bezier = "default";
        }
        {
          leaf = "layers";
          enabled = true;
          speed = 2.5;
          bezier = "snap";
          style = "fade";
        }
      ];

      permission = [
        {
          _args = [
            "${pkgs.grim}/bin/grim"
            "screencopy"
            "allow"
          ];
        }
        {
          _args = [
            "${pkgs.wayfreeze}/bin/wayfreeze"
            "screencopy"
            "allow"
          ];
        }
        {
          _args = [
            "${osConfig.programs.hyprland.portalPackage}/libexec/.*"
            "screencopy"
            "allow"
          ];
        }
      ];

      monitor = [
        {
          output = "DP-1";
          mode = "2560x1440@180";
          position = "0x0";
          scale = "1";
          vrr = 1;
        }
        {
          output = "DP-2";
          mode = "1920x1080@240";
          position = "-1920x360";
          scale = "1";
        }
        {
          output = "eDP-1";
          mode = "2160x1440@60";
          position = "auto";
          scale = "1";
        }
      ];

      workspace_rule = lib.optionals isDesktop [
        {
          workspace = "1";
          monitor = "DP-1";
        }
        {
          workspace = "2";
          monitor = "DP-1";
        }
        {
          workspace = "3";
          monitor = "DP-1";
        }
        {
          workspace = "4";
          monitor = "DP-1";
        }
        {
          workspace = "5";
          monitor = "DP-1";
        }
        {
          workspace = "6";
          monitor = "DP-1";
        }
        {
          workspace = "7";
          monitor = "DP-2";
        }
        {
          workspace = "8";
          monitor = "DP-2";
        }
        {
          workspace = "9";
          monitor = "DP-2";
        }
      ];

      env = [
        (mkEnv "XCURSOR_THEME" "Bibata-Modern-Classic")
        (mkEnv "XCURSOR_SIZE" "20")
        (mkEnv "QT_AUTO_SCREEN_SCALE_FACTOR" "1")
        (mkEnv "QT_QPA_PLATFORMTHEME" "gtk3")
        (mkEnv "QT_QPA_PLATFORM" "wayland")
        (mkEnv "GDK_BACKEND" "wayland")
        (mkEnv "XDG_THEME_DESKTOP_SCHEME" "prefer-dark")
        (mkEnv "XDG_CURRENT_DESKTOP" "Hyprland")
        (mkEnv "NIXOS_OZONE_WL" "1")
      ];

      bind = [
        # --- App Launchers ---
        (mkBind "SUPER + t" "hl.dsp.exec_cmd('foot')")
        (mkBind "SUPER + e" "hl.dsp.exec_cmd('thunar')")
        (mkBind "SUPER + w" "hl.dsp.exec_cmd('chromium')")
        (mkBind "SUPER + s" "hl.dsp.exec_cmd('firefox')")
        (mkBind "SUPER + space" "hl.dsp.exec_cmd('rofi -show drun')")

        # Screenshots & Utility
        (mkBind "Print" "hl.dsp.exec_cmd([[grim -g \"$(slurp)\" -t ppm - | satty -f -]])")
        (mkBind "SUPER + SHIFT + s" "hl.dsp.exec_cmd('freeze-screenshot')")
        (mkBind "CTRL + Print" "hl.dsp.exec_cmd([[grim - | satty -f -]])")
        (mkBind "SUPER + SHIFT + t" "hl.dsp.exec_cmd([[bash -c 'grim -g \"$(slurp)\" -t png - | convert - -resize 300% -sharpen 0x1 png:- | tesseract -l eng+rus stdin stdout | wl-copy']])")
        (mkBind "SUPER + SHIFT + w" "hl.dsp.exec_cmd('wallpicker')")

        # Window Management
        (mkBind "SUPER + q" "hl.dsp.window.close()")
        (mkBind "SUPER + d" "hl.dsp.window.fullscreen({ mode = 'maximized', action = 'toggle' })")
        (mkBind "SUPER + f" "hl.dsp.window.fullscreen({ mode = 'fullscreen', action = 'toggle' })")
        (mkBind "SUPER + c" "hl.dsp.window.float({ action = 'toggle' })")
        (mkBind "SUPER + p" "hl.dsp.window.pin()")
        (mkBind "SUPER + CTRL + c" "hl.dsp.window.center()")
        (mkBind "SUPER + n" "hl.dsp.window.move({ workspace = 'special:scratch', follow = false })")
        (mkBind "SUPER + grave" "hl.dsp.focus({ last = true })")

        (mkBind "ALT + Tab" "hl.dsp.window.cycle_next({ next = true })")
        (mkBind "SUPER + Tab" "hl.dsp.exec_cmd('rofi -show window')")

        # Cycle Focus Between Floating and Tiling Windows
        (mkBind "SUPER + SHIFT + space" ''
          function()
            local win = hl.get_active_window()
            if win and win.floating then
              hl.dispatch(hl.dsp.focus({ window = "tiled" }))
            else
              hl.dispatch(hl.dsp.focus({ window = "floating" }))
            end
          end
        '')

        # Focus Navigation
        (mkBind "SUPER + h" "hl.dsp.focus({ direction = 'left' })")
        (mkBind "SUPER + j" "hl.dsp.focus({ direction = 'down' })")
        (mkBind "SUPER + k" "hl.dsp.focus({ direction = 'up' })")
        (mkBind "SUPER + l" "hl.dsp.focus({ direction = 'right' })")
        (mkBind "SUPER + left" "hl.dsp.focus({ direction = 'left' })")
        (mkBind "SUPER + down" "hl.dsp.focus({ direction = 'down' })")
        (mkBind "SUPER + up" "hl.dsp.focus({ direction = 'up' })")
        (mkBind "SUPER + right" "hl.dsp.focus({ direction = 'right' })")

        # Window Swapping
        (mkBind "SUPER + SHIFT + h" "hl.dsp.window.swap({ direction = 'l' })")
        (mkBind "SUPER + SHIFT + j" "hl.dsp.window.swap({ direction = 'd' })")
        (mkBind "SUPER + SHIFT + k" "hl.dsp.window.swap({ direction = 'u' })")
        (mkBind "SUPER + SHIFT + l" "hl.dsp.window.swap({ direction = 'r' })")
        (mkBind "SUPER + SHIFT + left" "hl.dsp.window.swap({ direction = 'l' })")
        (mkBind "SUPER + SHIFT + down" "hl.dsp.window.swap({ direction = 'd' })")
        (mkBind "SUPER + SHIFT + up" "hl.dsp.window.swap({ direction = 'u' })")
        (mkBind "SUPER + SHIFT + right" "hl.dsp.window.swap({ direction = 'r' })")

        # Master Layout Controls
        (mkBind "SUPER + z" "hl.dsp.layout('swapwithmaster')")
        (mkBind "SUPER + m" "hl.dsp.layout('focusmaster')")
        (mkBind "SUPER + ALT + space" "hl.dsp.layout('orientationcycle')")

        (mkBind "SUPER + minus" "hl.dsp.layout('mfact -0.05')")
        (mkBind "SUPER + equal" "hl.dsp.layout('mfact +0.05')")
        (mkBind "SUPER + SHIFT + up" "hl.dsp.layout('addmaster')")
        (mkBind "SUPER + SHIFT + down" "hl.dsp.layout('removemaster')")
        (mkBind "SUPER + bracketleft" "hl.dsp.layout('removemaster')")
        (mkBind "SUPER + bracketright" "hl.dsp.layout('addmaster')")

        # Monitor Navigation
        (mkBind "SUPER + comma" "hl.dsp.focus({ monitor = 'l' })")
        (mkBind "SUPER + period" "hl.dsp.focus({ monitor = 'r' })")
        (mkBind "SUPER + SHIFT + comma" "hl.dsp.window.move({ monitor = 'l' })")
        (mkBind "SUPER + SHIFT + period" "hl.dsp.window.move({ monitor = 'r' })")

        # Workspaces
        (mkBind "SUPER + 1" "hl.dsp.focus({ workspace = 1 })")
        (mkBind "SUPER + 2" "hl.dsp.focus({ workspace = 2 })")
        (mkBind "SUPER + 3" "hl.dsp.focus({ workspace = 3 })")
        (mkBind "SUPER + 4" "hl.dsp.focus({ workspace = 4 })")
        (mkBind "SUPER + 5" "hl.dsp.focus({ workspace = 5 })")
        (mkBind "SUPER + 6" "hl.dsp.focus({ workspace = 6 })")
        (mkBind "SUPER + 7" "hl.dsp.focus({ workspace = 7 })")
        (mkBind "SUPER + 8" "hl.dsp.focus({ workspace = 8 })")
        (mkBind "SUPER + 9" "hl.dsp.focus({ workspace = 9 })")

        (mkBind "SUPER + ALT + 1" "hl.dsp.window.move({ workspace = 1 })")
        (mkBind "SUPER + ALT + 2" "hl.dsp.window.move({ workspace = 2 })")
        (mkBind "SUPER + ALT + 3" "hl.dsp.window.move({ workspace = 3 })")
        (mkBind "SUPER + ALT + 4" "hl.dsp.window.move({ workspace = 4 })")
        (mkBind "SUPER + ALT + 5" "hl.dsp.window.move({ workspace = 5 })")
        (mkBind "SUPER + ALT + 6" "hl.dsp.window.move({ workspace = 6 })")
        (mkBind "SUPER + ALT + 7" "hl.dsp.window.move({ workspace = 7 })")
        (mkBind "SUPER + ALT + 8" "hl.dsp.window.move({ workspace = 8 })")
        (mkBind "SUPER + ALT + 9" "hl.dsp.window.move({ workspace = 9 })")

        (mkBind "SUPER + SHIFT + 1" "hl.dsp.window.move({ workspace = 1, follow = false })")
        (mkBind "SUPER + SHIFT + 2" "hl.dsp.window.move({ workspace = 2, follow = false })")
        (mkBind "SUPER + SHIFT + 3" "hl.dsp.window.move({ workspace = 3, follow = false })")
        (mkBind "SUPER + SHIFT + 4" "hl.dsp.window.move({ workspace = 4, follow = false })")
        (mkBind "SUPER + SHIFT + 5" "hl.dsp.window.move({ workspace = 5, follow = false })")
        (mkBind "SUPER + SHIFT + 6" "hl.dsp.window.move({ workspace = 6, follow = false })")
        (mkBind "SUPER + SHIFT + 7" "hl.dsp.window.move({ workspace = 7, follow = false })")
        (mkBind "SUPER + SHIFT + 8" "hl.dsp.window.move({ workspace = 8, follow = false })")
        (mkBind "SUPER + SHIFT + 9" "hl.dsp.window.move({ workspace = 9, follow = false })")

        (mkBind "SUPER + Page_Up" "hl.dsp.focus({ workspace = 'e-1' })")
        (mkBind "SUPER + Page_Down" "hl.dsp.focus({ workspace = 'e+1' })")
        (mkBind "SUPER + u" "hl.dsp.focus({ workspace = 'e-1' })")
        (mkBind "SUPER + i" "hl.dsp.focus({ workspace = 'e+1' })")
        (mkBind "SUPER + CTRL + Page_Up" "hl.dsp.window.move({ workspace = 'e-1' })")
        (mkBind "SUPER + CTRL + Page_Down" "hl.dsp.window.move({ workspace = 'e+1' })")
        (mkBind "SUPER + CTRL + u" "hl.dsp.window.move({ workspace = 'e-1' })")
        (mkBind "SUPER + CTRL + i" "hl.dsp.window.move({ workspace = 'e+1' })")
        (mkBind "SUPER + BackSpace" "hl.dsp.focus({ workspace = 'previous' })")

        (mkBind "SUPER + a" "hl.dsp.workspace.toggle_special('scratch')")
        (mkBind "SUPER + Return" "hl.dsp.workspace.toggle_special('vpn')")

        (mkBind "SUPER + ALT + equal" "hl.dsp.exec_cmd('hypr-zoom in')")
        (mkBind "SUPER + ALT + minus" "hl.dsp.exec_cmd('hypr-zoom out')")
        (mkBind "SUPER + ALT + 0" "hl.dsp.exec_cmd('hypr-zoom reset')")

        (mkBind "CTRL + ALT + Delete" "hl.dsp.exit()")
        (mkBind "SUPER + SHIFT + p" "hl.dsp.exec_cmd([[bash -c 'hyprctl dispatch dpms off DP-1 && hyprctl dispatch dpms off DP-2']])")

        # Media keys
        (mkBindOpt "XF86AudioRaiseVolume"
          "hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0')"
          { locked = true; }
        )
        (mkBindOpt "XF86AudioLowerVolume" "hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-')" {
          locked = true;
        })
        (mkBindOpt "XF86AudioMute" "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')" {
          locked = true;
        })
        (mkBindOpt "XF86AudioMicMute" "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle')" {
          locked = true;
        })
        (mkBindOpt "XF86AudioPlay" "hl.dsp.exec_cmd('playerctl play-pause')" { locked = true; })
        (mkBindOpt "XF86AudioStop" "hl.dsp.exec_cmd('playerctl stop')" { locked = true; })
        (mkBindOpt "XF86AudioPrev" "hl.dsp.exec_cmd('playerctl previous')" { locked = true; })
        (mkBindOpt "XF86AudioNext" "hl.dsp.exec_cmd('playerctl next')" { locked = true; })
        (mkBindOpt "XF86MonBrightnessUp" "hl.dsp.exec_cmd('brightnessctl --class=backlight set +10%')" {
          locked = true;
        })
        (mkBindOpt "XF86MonBrightnessDown" "hl.dsp.exec_cmd('brightnessctl --class=backlight set 10%-')" {
          locked = true;
        })

        # Mouse Move and Resize
        (mkBindOpt "SUPER + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
        (mkBindOpt "SUPER + mouse:273" "hl.dsp.window.resize()" { mouse = true; })
      ];

      window_rule = [
        {
          name = "firefox-private-noscreenshare";
          match = {
            class = "^(firefox)$";
            title = ".*Private Browsing.*";
          };
          no_screen_share = true;
        }
        {
          name = "chromium-private-noscreenshare";
          match = {
            class = "^(chromium-browser)$";
            title = ".*[Ii]ncognito.*";
          };
          no_screen_share = true;
        }
        {
          name = "keepassxc-noscreenshare";
          match = {
            class = "^(org.keepassxc.KeePassXC)$";
          };
          no_screen_share = true;
        }
        {
          name = "portal-gtk-float";
          match = {
            class = "^(xdg-desktop-portal-gtk)$";
          };
          float = true;
        }
        {
          name = "share-screen-float";
          match = {
            title = "^(Share Screen)$";
          };
          float = true;
        }
        {
          name = "screen-share-float";
          match = {
            title = "^(Screen Share)$";
          };
          float = true;
        }
        {
          name = "satty-float";
          match = {
            class = "^(com.gabm.satty)$";
          };
          float = true;
        }
        {
          name = "chromium-pip";
          match = {
            class = "^(chromium-browser)$";
            title = "^(Picture-in-Picture)$";
          };
          float = true;
          pin = true;
        }
        {
          name = "firefox-pip";
          match = {
            class = "^(firefox)$";
            title = "^(Picture-in-Picture)$";
          };
          float = true;
          pin = true;
        }
        {
          name = "thunar-float";
          match = {
            class = "^(thunar)$";
          };
          float = true;
          size = "1000 700";
        }
        {
          name = "steam-float";
          match = {
            class = "^(steam)$";
          };
          float = true;
        }
        {
          name = "steam-main-tile";
          match = {
            class = "^(steam)$";
            title = "^(Steam)$";
          };
          tile = true;
        }
        {
          name = "steam-app";
          match = {
            class = "^(steam_app_)";
          };
          workspace = "6";
          immediate = true;
        }
        {
          name = "Throne";
          match = {
            class = "^(Throne)";
          };
          workspace = "special:vpn silent";
          immediate = true;
        }
      ];

      layer_rule = [
        {
          name = "selection-noanim";
          match = {
            namespace = "selection";
          };
          no_anim = true;
        }
      ];

      config = {
        general = {
          gaps_in = s.gaps_in;
          gaps_out = s.gaps_out;
          border_size = s.border_size;
          col = {
            active_border = t.hypr.active_border;
            inactive_border = t.hypr.inactive_border;
          };
          allow_tearing = true;
          layout = "master";
        };
        decoration = {
          rounding = s.rounding;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          blur = {
            enabled = s.blur;
            size = 4;
            passes = 5;
            noise = 0.02;
            brightness = 1.0;
            contrast = 0.89;
            vibrancy = 1.2;
            new_optimizations = true;
            ignore_opacity = true;
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
          enabled = s.animations;
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
            scroll_factor = 0.5;
            clickfinger_behavior = true;
            disable_while_typing = true;
            middle_button_emulation = true;
          };
        };
        cursor = {
          inactive_timeout = 5;
          warp_on_change_workspace = true;
        };
        master = {
          new_status = "slave";
          mfact = 0.5;
          orientation = "left";
          smart_resizing = true;
          drop_at_cursor = true;
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
      };

      on = [
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''
              function()
                hl.exec_cmd("bash ~/.config/hypr/autostart.sh")
                hl.exec_cmd("QT_QPA_PLATFORM=wayland Throne &", { workspace = "special:vpn silent" })
              end
            '')
          ];
        }
      ];
    };
  };

  xdg.configFile."hypr/autostart.sh".source = pkgs.writeShellScript "hypr-autostart" ''

    if [ -f "$HOME/.config/wallpaper" ]; then
      swaybg -i "$HOME/.config/wallpaper" -m fill &
    fi

    wl-clip-persist --clipboard regular --reconnect-tries 0 &
  '';
}
