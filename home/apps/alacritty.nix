{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      general.import = [ "~/.config/alacritty/dank-theme.toml" ];

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

      colors.draw_bold_text_with_bright_colors = false;

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
