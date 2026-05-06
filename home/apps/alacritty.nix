{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      window = {
        padding = {
          x = 25;
          y = 25;
        };
        opacity = 0.78;
      };

      font = {
        normal.family = "JetBrains Mono Nerd Font";
        size = 12.0;
        offset = {
          x = 0;
          y = 0;
        };
      };

      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
        thickness = 0.2;
        blink_timeout = 0;
      };

      terminal.shell.program = "zsh";

      colors = {
        draw_bold_text_with_bright_colors = false;

        primary = {
          background = "#141218";
          foreground = "#e7e0e8";
        };

        selection = {
          text = "#e7e0e8";
          background = "#4e3d75";
        };

        cursor = {
          text = "#141218";
          cursor = "#d1bcfd";
        };

        normal = {
          black = "#141218";
          red = "#ff728e";
          green = "#7efd99";
          yellow = "#ffda72";
          blue = "#bea6f0";
          magenta = "#4f3d75";
          cyan = "#d1bcfd";
          white = "#f4efff";
        };

        bright = {
          black = "#9c98a4";
          red = "#ff9fb2";
          green = "#a5ffb8";
          yellow = "#ffe7a5";
          blue = "#d9c7ff";
          magenta = "#dfd1ff";
          cyan = "#ebe1ff";
          white = "#faf8ff";
        };
      };

      keyboard.bindings = [
        {
          key = "V";
          mods = "Control";
          action = "Paste";
        }
        {
          key = "F";
          mods = "Control|Shift";
          action = "SearchForward";
        }
      ];
    };
  };
}
