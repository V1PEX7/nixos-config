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
  inherit (osConfig.modules.desktop.hyprland) monitors;

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
  mkBindP = key: action: {
    _args = [
      key
      (lib.generators.mkLuaInline action)
      {
        dont_inhibit = true;
      }
    ];
  };
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
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

      monitor = map (m: removeAttrs m [ "workspaces" ]) monitors;

      workspace_rule = lib.concatMap (
        m:
        map (ws: {
          workspace = toString ws;
          monitor = m.output;
        }) m.workspaces
      ) monitors;

      bind = [
        # App Launchers
        (mkBind "SUPER + t" "hl.dsp.exec_cmd('uwsm app -- foot')")
        (mkBind "SUPER + e" "hl.dsp.exec_cmd('uwsm app -- thunar')")
        (mkBind "SUPER + w" "hl.dsp.exec_cmd('uwsm app -- firefox')")
        (mkBind "SUPER + space" "hl.dsp.exec_cmd('uwsm app -- rofi -show drun')")

        # Screenshots & Utility
        (mkBind "Print" "hl.dsp.exec_cmd([[grim -g \"$(slurp)\" -t ppm - | satty -f -]])")
        (mkBind "SUPER + SHIFT + s" "hl.dsp.exec_cmd('freeze-screenshot')")
        (mkBind "CTRL + Print" "hl.dsp.exec_cmd([[grim - | satty -f -]])")
        (mkBind "SUPER + SHIFT + t" "hl.dsp.exec_cmd([[bash -c 'grim -g \"$(slurp)\" -t png - | convert - -resize 300% -sharpen 0x1 png:- | tesseract -l eng+rus stdin stdout | wl-copy']])")
        (mkBind "SUPER + SHIFT + w" "hl.dsp.exec_cmd('wallpicker')")

        # Window Management
        (mkBindP "SUPER + q" "hl.dsp.window.close()")
        (mkBindP "SUPER + d" "hl.dsp.window.fullscreen({ mode = 'maximized', action = 'toggle' })")
        (mkBindP "SUPER + f" "hl.dsp.window.fullscreen({ mode = 'fullscreen', action = 'toggle' })")
        (mkBindP "SUPER + c" ''
          function()
            local win = hl.get_active_window()
            if not win then return end
            local was_floating = win.floating
            hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
            if was_floating then return end
            local mon = win.monitor or hl.get_active_monitor()
            if not mon then return end
            hl.dispatch(hl.dsp.window.resize({
              x = math.floor(mon.width / mon.scale * 0.6),
              y = math.floor(mon.height / mon.scale * 0.6),
              relative = false,
            }))
            hl.dispatch(hl.dsp.window.center())
          end
        '')
        (mkBindP "SUPER + p" "hl.dsp.window.pin()")
        (mkBindP "SUPER + CTRL + c" "hl.dsp.window.center()")
        (mkBindP "SUPER + n" "hl.dsp.window.move({ workspace = 'special:scratch', follow = false })")
        (mkBindP "SUPER + grave" "hl.dsp.focus({ last = true })")

        (mkBindP "ALT + Tab" "hl.dsp.window.cycle_next({ next = true })")
        (mkBindP "SUPER + Tab" "hl.dsp.exec_cmd('rofi -show window')")

        # Cycle Focus Between Floating and Tiling Windows
        (mkBindP "SUPER + SHIFT + space" ''
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
        (mkBindP "SUPER + h" "hl.dsp.focus({ direction = 'left' })")
        (mkBindP "SUPER + j" "hl.dsp.focus({ direction = 'down' })")
        (mkBindP "SUPER + k" "hl.dsp.focus({ direction = 'up' })")
        (mkBindP "SUPER + l" "hl.dsp.focus({ direction = 'right' })")
        (mkBindP "SUPER + left" "hl.dsp.focus({ direction = 'left' })")
        (mkBindP "SUPER + down" "hl.dsp.focus({ direction = 'down' })")
        (mkBindP "SUPER + up" "hl.dsp.focus({ direction = 'up' })")
        (mkBindP "SUPER + right" "hl.dsp.focus({ direction = 'right' })")

        # Window Swapping
        (mkBindP "SUPER + SHIFT + h" "hl.dsp.window.swap({ direction = 'l' })")
        (mkBindP "SUPER + SHIFT + j" "hl.dsp.window.swap({ direction = 'd' })")
        (mkBindP "SUPER + SHIFT + k" "hl.dsp.window.swap({ direction = 'u' })")
        (mkBindP "SUPER + SHIFT + l" "hl.dsp.window.swap({ direction = 'r' })")
        (mkBindP "SUPER + SHIFT + left" "hl.dsp.window.swap({ direction = 'l' })")
        (mkBindP "SUPER + SHIFT + down" "hl.dsp.window.swap({ direction = 'd' })")
        (mkBindP "SUPER + SHIFT + up" "hl.dsp.window.swap({ direction = 'u' })")
        (mkBindP "SUPER + SHIFT + right" "hl.dsp.window.swap({ direction = 'r' })")

        # Master Layout Controls
        (mkBindP "SUPER + z" "hl.dsp.layout('swapwithmaster')")
        (mkBindP "SUPER + m" "hl.dsp.layout('focusmaster')")
        (mkBindP "SUPER + ALT + space" "hl.dsp.layout('orientationcycle')")

        (mkBindP "SUPER + minus" "hl.dsp.layout('mfact -0.05')")
        (mkBindP "SUPER + equal" "hl.dsp.layout('mfact +0.05')")

        (mkBindP "SUPER + bracketleft" "hl.dsp.layout('removemaster')")
        (mkBindP "SUPER + bracketright" "hl.dsp.layout('addmaster')")

        # Monitor Navigation
        (mkBindP "SUPER + comma" "hl.dsp.focus({ monitor = 'l' })")
        (mkBindP "SUPER + period" "hl.dsp.focus({ monitor = 'r' })")
        (mkBindP "SUPER + SHIFT + comma" "hl.dsp.window.move({ monitor = 'l' })")
        (mkBindP "SUPER + SHIFT + period" "hl.dsp.window.move({ monitor = 'r' })")

        # Workspaces
        (mkBindP "SUPER + 1" "hl.dsp.focus({ workspace = 1 })")
        (mkBindP "SUPER + 2" "hl.dsp.focus({ workspace = 2 })")
        (mkBindP "SUPER + 3" "hl.dsp.focus({ workspace = 3 })")
        (mkBindP "SUPER + 4" "hl.dsp.focus({ workspace = 4 })")
        (mkBindP "SUPER + 5" "hl.dsp.focus({ workspace = 5 })")
        (mkBindP "SUPER + 6" "hl.dsp.focus({ workspace = 6 })")
        (mkBindP "SUPER + 7" "hl.dsp.focus({ workspace = 7 })")
        (mkBindP "SUPER + 8" "hl.dsp.focus({ workspace = 8 })")
        (mkBindP "SUPER + 9" "hl.dsp.focus({ workspace = 9 })")

        (mkBindP "SUPER + ALT + 1" "hl.dsp.window.move({ workspace = 1 })")
        (mkBindP "SUPER + ALT + 2" "hl.dsp.window.move({ workspace = 2 })")
        (mkBindP "SUPER + ALT + 3" "hl.dsp.window.move({ workspace = 3 })")
        (mkBindP "SUPER + ALT + 4" "hl.dsp.window.move({ workspace = 4 })")
        (mkBindP "SUPER + ALT + 5" "hl.dsp.window.move({ workspace = 5 })")
        (mkBindP "SUPER + ALT + 6" "hl.dsp.window.move({ workspace = 6 })")
        (mkBindP "SUPER + ALT + 7" "hl.dsp.window.move({ workspace = 7 })")
        (mkBindP "SUPER + ALT + 8" "hl.dsp.window.move({ workspace = 8 })")
        (mkBindP "SUPER + ALT + 9" "hl.dsp.window.move({ workspace = 9 })")

        (mkBindP "SUPER + SHIFT + 1" "hl.dsp.window.move({ workspace = 1, follow = false })")
        (mkBindP "SUPER + SHIFT + 2" "hl.dsp.window.move({ workspace = 2, follow = false })")
        (mkBindP "SUPER + SHIFT + 3" "hl.dsp.window.move({ workspace = 3, follow = false })")
        (mkBindP "SUPER + SHIFT + 4" "hl.dsp.window.move({ workspace = 4, follow = false })")
        (mkBindP "SUPER + SHIFT + 5" "hl.dsp.window.move({ workspace = 5, follow = false })")
        (mkBindP "SUPER + SHIFT + 6" "hl.dsp.window.move({ workspace = 6, follow = false })")
        (mkBindP "SUPER + SHIFT + 7" "hl.dsp.window.move({ workspace = 7, follow = false })")
        (mkBindP "SUPER + SHIFT + 8" "hl.dsp.window.move({ workspace = 8, follow = false })")
        (mkBindP "SUPER + SHIFT + 9" "hl.dsp.window.move({ workspace = 9, follow = false })")

        (mkBindP "SUPER + Page_Up" "hl.dsp.focus({ workspace = 'e-1' })")
        (mkBindP "SUPER + Page_Down" "hl.dsp.focus({ workspace = 'e+1' })")
        (mkBindP "SUPER + u" "hl.dsp.focus({ workspace = 'e-1' })")
        (mkBindP "SUPER + i" "hl.dsp.focus({ workspace = 'e+1' })")
        (mkBindP "SUPER + CTRL + Page_Up" "hl.dsp.window.move({ workspace = 'e-1' })")
        (mkBindP "SUPER + CTRL + Page_Down" "hl.dsp.window.move({ workspace = 'e+1' })")
        (mkBindP "SUPER + CTRL + u" "hl.dsp.window.move({ workspace = 'e-1' })")
        (mkBindP "SUPER + CTRL + i" "hl.dsp.window.move({ workspace = 'e+1' })")
        (mkBindP "SUPER + BackSpace" "hl.dsp.focus({ workspace = 'previous' })")

        (mkBindP "SUPER + a" "hl.dsp.workspace.toggle_special('scratch')")
        (mkBindP "SUPER + Return" "hl.dsp.workspace.toggle_special('vpn')")

        (mkBindP "SUPER + ALT + equal" "hl.dsp.exec_cmd('hypr-zoom in')")
        (mkBindP "SUPER + ALT + minus" "hl.dsp.exec_cmd('hypr-zoom out')")
        (mkBindP "SUPER + ALT + 0" "hl.dsp.exec_cmd('hypr-zoom reset')")

        (mkBindP "CTRL + ALT + Delete" "hl.dsp.exit()")
        (mkBindP "SUPER + ALT + l" "hl.dsp.exec_cmd('loginctl lock-session')")

        # Media keys
        (mkBindOpt "XF86AudioRaiseVolume"
          "hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0')"
          {
            locked = true;
            dont_inhibit = true;
          }
        )
        (mkBindOpt "XF86AudioLowerVolume" "hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-')" {
          locked = true;
          dont_inhibit = true;
        })
        (mkBindOpt "XF86AudioMute" "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')" {
          locked = true;
          dont_inhibit = true;
        })
        (mkBindOpt "XF86AudioMicMute" "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle')" {
          locked = true;
          dont_inhibit = true;
        })
        (mkBindOpt "XF86AudioPlay" "hl.dsp.exec_cmd('playerctl play-pause')" {
          locked = true;
          dont_inhibit = true;
        })
        (mkBindOpt "XF86AudioStop" "hl.dsp.exec_cmd('playerctl stop')" {
          locked = true;
          dont_inhibit = true;
        })
        (mkBindOpt "XF86AudioPrev" "hl.dsp.exec_cmd('playerctl previous')" {
          locked = true;
          dont_inhibit = true;
        })
        (mkBindOpt "XF86AudioNext" "hl.dsp.exec_cmd('playerctl next')" {
          locked = true;
          dont_inhibit = true;
        })
        (mkBindOpt "XF86MonBrightnessUp" "hl.dsp.exec_cmd('brightnessctl --class=backlight set +10%')" {
          locked = true;
          dont_inhibit = true;
        })
        (mkBindOpt "XF86MonBrightnessDown" "hl.dsp.exec_cmd('brightnessctl --class=backlight set 10%-')" {
          locked = true;
          dont_inhibit = true;
        })

        # Mouse Move and Resize
        (mkBindOpt "SUPER + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
        (mkBindOpt "SUPER + mouse:273" "hl.dsp.window.resize()" { mouse = true; })
        (mkBindOpt "SUPER + g" "hl.dsp.window.drag()" { mouse = true; })
        (mkBindOpt "SUPER + r" "hl.dsp.window.resize()" { mouse = true; })
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
          name = "satty-float";
          match = {
            class = "^(com.gabm.satty)$";
          };
          float = true;
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
                hl.exec_cmd("uwsm app -- Throne", { workspace = "special:vpn silent" })
              end
            '')
          ];
        }
      ];
    };
  };

  xdg.configFile."hypr/autostart.sh".source = pkgs.writeShellScript "hypr-autostart" ''

    if [ -f "$HOME/.config/wallpaper" ]; then
      uwsm app -- swaybg -i "$HOME/.config/wallpaper" -m fill &
    fi

    uwsm app -- wl-clip-persist --clipboard regular --reconnect-tries 0 &
  '';
}
