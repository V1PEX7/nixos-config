{ pkgs, ... }:
let
  kbdLayout = pkgs.writeShellScript "waybar-kbd-layout" ''
    out=""
    if command -v mmsg >/dev/null 2>&1; then
      out=$(mmsg -g -k 2>/dev/null | ${pkgs.gawk}/bin/awk '/kb_layout/ {print $NF; exit}')
      [ -z "$out" ] && out=$(mmsg --get-kb-layout 2>/dev/null)
    fi
    [ -z "$out" ] && out="??"
    printf '{"text":"%s","tooltip":"Keyboard layout"}\n' "$out"
  '';
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 28;
      spacing = 10;

      modules-left = [
        "dwl/tags"
        "dwl/window"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "tray"
        "privacy"
        "custom/keyboard"
        "pulseaudio"
        "network"
        "battery"
        "cpu"
        "temperature"
        "memory"
      ];

      "dwl/tags" = {
        num-tags = 9;
      };

      "dwl/window" = {
        format = "{title}";
        max-length = 60;
        tooltip = false;
      };

      clock = {
        format = "{:%H:%M  %a %d %b}";
        format-alt = "{:%Y-%m-%d %H:%M:%S}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        interval = 30;
      };

      privacy = {
        icon-spacing = 4;
        icon-size = 14;
        transition-duration = 250;
        modules = [
          {
            type = "screenshare";
            tooltip = true;
            tooltip-icon-size = 24;
          }
          {
            type = "audio-in";
            tooltip = true;
            tooltip-icon-size = 24;
          }
        ];
      };

      pulseaudio = {
        format = " {volume}%";
        format-muted = " muted";
        format-icons.default = [
          ""
          ""
        ];
        on-click = "pavucontrol";
        scroll-step = 5;
      };

      network = {
        format-wifi = " {essid} {signalStrength}%";
        format-ethernet = " eth";
        format-disconnected = " off";
        tooltip-format = "{ifname}: {ipaddr}";
        on-click = "alacritty -e nmtui";
        interval = 5;
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };

      cpu = {
        format = " {usage}%";
        interval = 2;
        tooltip = false;
      };

      temperature = {
        thermal-zone = 0;
        format = " {temperatureC}°C";
        critical-threshold = 85;
        interval = 2;
      };

      memory = {
        format = " {used:0.1f}G";
        interval = 5;
        tooltip-format = "{used:0.1f}G / {total:0.1f}G";
      };

      "custom/keyboard" = {
        exec = "${kbdLayout}";
        interval = 2;
        return-type = "json";
        format = " {}";
      };

      tray = {
        icon-size = 16;
        spacing = 8;
      };
    };

    style = ''
      * {
        font-family: "JetBrains Mono Nerd Font", monospace;
        font-size: 12px;
        min-height: 0;
        border-radius: 0;
      }

      window#waybar {
        background-color: rgba(30, 30, 46, 0.94);
        color: #ffffff;
        border-bottom: 1px solid rgba(180, 190, 254, 0.4);
      }

      #tags button {
          padding: 0 2px;
          margin: 0;
          min-width: 18px;
          color: #9398a8;
          background: transparent;
          border-bottom: 2px solid transparent;
          border-radius: 0;
      }

      #tags button.occupied {
        color: #c5f5ec;
        border-bottom-color: rgba(180, 190, 254, 0.35);
      }

      #tags button.focused {
        color: #e8d4ff;
        border-bottom-color: #b4befe;
      }

      #tags button.urgent {
        color: #ffffff;
        border-bottom-color: #f38ba8;
      }

      #window {
        padding: 0 6px;
        color: #e6e9ef;
      }

      #clock {
        padding: 0 12px;
        color: #ffffff;
        font-weight: bold;
      }

      #pulseaudio,
      #network,
      #battery,
      #cpu,
      #temperature,
      #memory,
      #custom-keyboard,
      #tray {
        padding: 0 8px;
        color: #ffffff;
      }
      #privacy {
        padding: 0 8px;
        color: #ffffff;
      }

      #pulseaudio.muted     { color: #9398a8; }
      #network.disconnected { color: #f38ba8; }
      #battery.warning      { color: #f9e2af; }
      #battery.critical     { color: #f38ba8; }
      #battery.charging     { color: #a6e3a1; }
      #temperature.critical { color: #f38ba8; }
      #cpu                  { color: #cfe0ff; }
      #memory               { color: #e8d4ff; }
      #custom-keyboard      { color: #c5f5ec; }

      tooltip {
        background-color: rgba(30, 30, 46, 0.97);
        border: 1px solid #b4befe;
        border-radius: 0;
      }

      tooltip label {
        color: #ffffff;
        padding: 4px;
      }
    '';
  };
}
