{ pkgs, ... }:
let
  t = import ../theme.nix;
in
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
          background = t.term.bg;
          foreground = t.term.fg;
        };

        selection = {
          text = t.term.selText;
          background = t.term.selBg;
        };

        cursor = {
          text = t.term.curText;
          cursor = t.term.curCursor;
        };

        normal = {
          black = t.term.black;
          red = t.term.red;
          green = t.term.green;
          yellow = t.term.yellow;
          blue = t.term.blue;
          magenta = t.term.magenta;
          cyan = t.term.cyan;
          white = t.term.white;
        };

        bright = {
          black = t.term.brBlack;
          red = t.term.brRed;
          green = t.term.brGreen;
          yellow = t.term.brYellow;
          blue = t.term.brBlue;
          magenta = t.term.brMagenta;
          cyan = t.term.brCyan;
          white = t.term.brWhite;
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
