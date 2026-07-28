{
  theme,
  settings,
  ...
}:
let
  t = theme;
  s = settings;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      reload_style_on_change = true;
      position = "top";
      height = 24;
      margin-right = 0;
      margin-left = 0;
      margin-top = 0;
      margin-bottom = 0;
      spacing = 0;

      modules-left = [
        "custom/nix"
        "hyprland/workspaces"
        #"mpris"
        "hyprland/window"
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
        "hyprland/language"
        "battery"
      ];

      "custom/nix" = {
        format = "";
        tooltip-format = "NixOS";
      };

      "hyprland/workspaces" = {
        format = "{id}";
        on-click = "activate";
        persistent-workspaces."*" = 9;
      };

      "hyprland/window" = {
        format = "{title}";
        max-length = 20;
        rewrite = {
          "^$" = "󰍹 Desktop";
          ".*Private Browsing.*" = "󰈹 Firefox";
        };
      };

      privacy = {
        icon-spacing = 4;
        icon-size = 16;
        transition-duration = 250;
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
            month = "<span color='${t.calMonth}'><b>{}</b></span>";
            weekdays = "<span color='${t.calWeekdays}'><b>{}</b></span>";
            today = "<span color='${t.calToday}'><b>{}</b></span>";
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
        on-click = "foot -e nmtui";
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
        format = " {used:0.1f}GB";
        on-click = "foot -e btop";
      };

      cpu = {
        interval = 2;
        format = "{usage:02}% 󰍛";
        on-click = "foot -e btop";
        states = {
          warning = 60;
          critical = 90;
        };
      };

      "hyprland/language" = {
        tooltip-format = "Keyboard layout";
        format = " {short}";
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
        background-color: ${t.bg};
        color: ${t.fg};
        border-radius: 0;
      }

      #custom-nix {
        font-size: 15px;
        margin: 3px 4px;
        padding: 0 8px;
        border-radius: 5px;
        background-color: ${t.surface};
      }

      #workspaces {
        margin: 3px 2px;
        padding: 0 1px;
        background-color: ${t.surface};
        margin-left: 0px;
      }

      #workspaces button {
        margin: 0px 0px;
        padding: 0 4px;
        background-color: transparent;
        color: ${t.fg};
        border-radius: 5px;
        transition: 0.15s ease-in-out;
      }

      #workspaces button:hover {
        background: ${t.hover};
        color: ${t.contrast};
      }

      #workspaces button.empty {
        color: alpha(${t.fg}, ${t.dim});
        opacity: 0.45;
        transition: all 0.15s ease-in-out;
      }

      #workspaces button.active {
        background-color: ${t.accent};
        color: ${t.contrast};
        opacity: 1;
        margin: 0px 0px;
        padding: 0 4px;
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
      #language {
        padding: 0 8px;
        color: ${t.fg};
        margin: 3px 4px 3px 0px;
      }

      #tray {
        background-color: ${t.surface};
      }

      #window {
        margin: 3px 2px;
      }

      #window,
      #memory,
      #clock,
      #language {
        background-color: ${t.surface};
      }

      #battery {
        background-color: ${t.surface};
        color: ${t.fg};
      }

      #battery.charging,
      #battery.plugged {
        color: ${t.fg};
        background-color: ${t.surface};
      }

      @keyframes blink {
        to {
          background-color: ${t.fg};
          color: ${t.contrast};
        }
      }

      #battery.critical:not(.charging) {
        background-color: ${t.red};
        color: ${t.fg};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #backlight {
        background-color: ${t.surface};
        color: ${t.fg};
      }

      #power-profiles-daemon.performance {
        background-color: ${t.accent};
        color: ${t.contrast};
      }

      #power-profiles-daemon.balanced {
        background-color: ${t.surface};
        color: ${t.fg};
      }

      #power-profiles-daemon.power-saver {
        background-color: ${t.surface};
        color: ${t.fg};
      }

      #cpu {
        background-color: ${t.surface};
        color: ${t.fg};
      }

      #cpu.warning {
        background-color: ${t.accent};
        color: ${t.contrast};
      }

      #cpu.critical {
        background-color: ${t.red};
        color: ${t.fg};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #mpris {
        background-color: ${t.surface};
        color: ${t.fg};
      }

      #network {
        background-color: ${t.surface};
      }

      #network.disconnected {
        background-color: ${t.accent};
        color: ${t.contrast};
      }

      #bluetooth {
        background-color: ${t.surface};
      }

      #bluetooth.disabled {
        background-color: ${t.accent};
        color: ${t.contrast};
      }

      #pulseaudio {
        background-color: ${t.surface};
        color: ${t.fg};
      }

      #pulseaudio.muted {
        background-color: ${t.accent};
        color: ${t.contrast};
      }

      @keyframes blink-inhibitor {
        to {
          color: @background;
        }
      }

      #mpris {
        font-size: 13px;
        margin: 3px 2px;
      }

      #privacy {
        margin: 3px 4px 3px 0px;
        padding: 0 8px;
        background-color: ${t.surface};
      }

      #privacy-item {
        color: ${t.red};
      }

      #privacy-item.screenshare {
        color: ${t.accent};
      }

      tooltip {
        padding: 4px;
        background: ${t.surface};
        border: 1px solid alpha(${t.fg}, 0.8);
        border-radius: 8px;
        box-shadow: 1px 1px 3px 1px ${t.shadow};
        font-size: 12px;
      }

      tooltip label {
        color: ${t.fg};
        font-weight: normal;
      }
    '';
  };
}
