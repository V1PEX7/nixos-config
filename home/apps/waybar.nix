{ pkgs, ... }:
let
  kbdLayout = pkgs.writeShellScript "waybar-kbd-layout" ''
    out=""
    if command -v mmsg >/dev/null 2>&1; then
      out=$(mmsg -g -k 2>/dev/null | ${pkgs.gawk}/bin/awk 'NF {print $NF; exit}')
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
      reload_style_on_change = true;
      position = "top";
      height = 24;
      margin-right = 5;
      margin-left = 5;
      margin-top = 1;
      margin-bottom = 3;
      spacing = 0;

      modules-left = [
        "custom/nix"
        "dwl/tags"
        "mpris"
        "dwl/window"
      ];

      modules-center = [
        "privacy"
        "clock"
      ];

      modules-right = [
        "tray"
        "network"
        "backlight"
        #"bluetooth"
        "pulseaudio"
        "power-profiles-daemon"
        "memory"
        "cpu"
        "custom/keyboard"
        "battery"
      ];

      "custom/nix" = {
        format = "";
        tooltip-format = "NixOS";
      };

      "dwl/tags" = {
        num-tags = 9;
      };

      "dwl/window" = {
        format = "{title}";
        max-length = 20;
        rewrite."^$" = "󰡸 Desktop";
      };

      mpris = {
        format = "  {dynamic}";
        format-paused = " {status_icon} {dynamic}";
        interval = 1;
        dynamic-order = [
          "artist"
          "position"
          "length"
        ];
        dynamic-importance-order = [
          "position"
          "length"
          "artist"
        ];
        tooltip-format = "{player} ({status}):\n{artist} - {title}";
        status-icons.paused = "󰖛";
        ignored-players = [
          "chromium"
          "librewolf"
        ];
      };

      privacy = {
        icon-spacing = 4;
        icon-size = 16;
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

      clock = {
        format = "{:%H:%M}";
        format-alt = "{:%A, %d %B %Y - %H:%M}";
        tooltip-format = "<span>{calendar}</span>";
        calendar = {
          mode = "month";
          mode-mon-col = 3;
          on-click-right = "mode";
          format = {
            month = "<span color='#ffead3'><b>{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b>{}</b></span>";
          };
        };
      };

      network = {
        format-icons = [
          "󰤯"
          "󰤟"
          "󰤢"
          "󰤥"
          "󰤨"
        ];
        format = "{icon}";
        format-wifi = "{signalStrength}% {icon}";
        format-ethernet = " {bandwidthDownBytes}  {bandwidthUpBytes} 󰈀";
        format-disconnected = "󰤮";
        tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
        tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
        tooltip-format-disconnected = "Disconnected";
        interval = 3;
        spacing = 1;
        on-click = "alacritty -e nmtui";
      };

      tray = {
        icon-size = 14;
        spacing = 5;
        show-passive-items = true;
      };

      backlight = {
        format = "{percent}% {icon}";
        format-icons = [
          "🌑"
          "🌘"
          "🌗"
          "🌖"
          "🌕"
        ];
      };

      bluetooth = {
        format = " {status}";
        format-disabled = "󰂲";
        format-connected = "";
        tooltip-format = "Devices connected: {num_connections}";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        on-click = "pavucontrol";
        tooltip-format = "Playing at {volume}%";
        scroll-step = 5;
        format-muted = "󰝟";
        format-icons.default = [
          ""
          ""
          ""
        ];
      };

      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };

      memory = {
        interval = 2;
        format = " {used:0.1f}GB";
        on-click = "alacritty -e btop";
      };

      cpu = {
        interval = 2;
        format = "{usage:02}% 󰍛";
        on-click = "alacritty -e btop";
      };

      "custom/keyboard" = {
        exec = "${kbdLayout}";
        interval = 2;
        return-type = "json";
        format = " {}";
      };

      battery = {
        format = "{capacity}% {icon}";
        format-discharging = "{capacity}% {icon}";
        format-charging = "{capacity}% {icon}";
        format-plugged = "󰂅";
        format-full = "󰂅";
        format-icons = {
          charging = [
            "󰢜"
            "󰂆"
            "󰂇"
            "󰂈"
            "󰢝"
            "󰂉"
            "󰢞"
            "󰂊"
            "󰂋"
            "󰂅"
          ];
          default = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };
        tooltip-format-discharging = "{timeTo}";
        tooltip-format-charging = "{timeTo}";
        interval = 5;
        states = {
          warning = 20;
          critical = 10;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font Propo";
        font-size: 12px;
        font-weight: bold;
        border-radius: 5px;
        min-height: 20px;
      }

      tooltip {
        opacity: 1;
      }

      window#waybar {
        background-color: #131315;
        color: #e6d8ba;
        border-radius: 10px;
      }

      #custom-nix {
        font-size: 15px;
        margin: 3px 4px;
        padding: 0 8px;
        border-radius: 5px;
        background-color: #27272a;
      }

      #tags {
        margin: 3px 2px;
        padding: 0 1px;
        background-color: #27272a;
        margin-left: 0px;
      }

      #tags button {
        margin: 0px 0px;
        padding: 0 4px;
        background-color: transparent;
        color: #e6d8ba;
        border-radius: 5px;
        transition: 0.15s ease-in-out;
      }

      #tags button:hover {
        background: #3f3f46;
        color: #000;
      }

      #tags button.focused {
        background-color: #ff9b71;
        color: #000;
        margin: 0px 0px;
        padding: 0 4px;
      }

      #tags button:not(.occupied) {
        color: alpha(#e6d8ba, 0.4);
        opacity: 0.45;
        transition: all 0.15s ease-in-out;
      }

      #tags button:not(.occupied).focused {
        background-color: #e6d8ba;
        color: #000;
      }

      #window,
      #clock,
      #battery,
      #cpu,
      #memory,
      #mpris,
      #network,
      #pulseaudio,
      #power-profiles-daemon,
      #tray,
      #bluetooth,
      #backlight,
      #custom-keyboard {
        padding: 0 8px;
        color: #e6d8ba;
        margin: 3px 4px 3px 0px;
      }

      #tray {
        background-color: #27272a;
      }

      #window {
        margin: 3px 2px;
      }

      #window,
      #memory,
      #clock,
      #custom-keyboard {
        background-color: #27272a;
      }

      #battery {
        background-color: #27272a;
        color: #e6d8ba;
      }

      #battery.charging,
      #battery.plugged {
        color: #e6d8ba;
        background-color: #27272a;
      }

      @keyframes blink {
        to {
          background-color: #e6d8ba;
          color: #000000;
        }
      }

      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #e6d8ba;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #backlight {
        background-color: #27272a;
        color: #e6d8ba;
      }

      #power-profiles-daemon.performance {
        background-color: #ff9b71;
        color: #000;
      }

      #power-profiles-daemon.balanced {
        background-color: #27272a;
        color: #e6d8ba;
      }

      #power-profiles-daemon.power-saver {
        background-color: #27272a;
        color: #e6d8ba;
      }

      #cpu {
        background-color: #27272a;
        color: #e6d8ba;
      }

      #mpris {
        background-color: #27272a;
        color: #e6d8ba;
      }

      #network {
        background-color: #27272a;
      }

      #network.disconnected {
        background-color: #ff9b71;
        color: #000;
      }

      #bluetooth {
        background-color: #27272a;
      }

      #bluetooth.disabled {
        background-color: #ff9b71;
        color: #000;
      }

      #pulseaudio {
        background-color: #27272a;
        color: #e6d8ba;
      }

      #pulseaudio.muted {
        background-color: #ff9b71;
        color: #000;
      }

      @keyframes blink-inhibitor {
        to {
          color: @background;
        }
      }

      #mpris {
        background-color: #27272a;
        color: #e6d8ba;
        font-size: 13px;
        margin: 3px 2px;
      }

      tooltip {
        padding: 4px;
        background: #27272a;
        border: 1px solid alpha(#e6d8ba, 0.8);
        border-radius: 8px;
        box-shadow: 1px 1px 3px 1px #131313;
        font-size: 12px;
      }

      tooltip label {
        color: #e6d8ba;
        font-weight: normal;
      }
    '';
  };
}
