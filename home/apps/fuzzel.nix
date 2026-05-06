{ ... }:
{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "JetBrains Mono Nerd Font:size=12";
        dpi-aware = "no";
        prompt = "''";
        icon-theme = "Papirus-Dark";
        terminal = "alacritty -e";
        layer = "overlay";
        width = 40;
        lines = 12;
        horizontal-pad = 16;
        vertical-pad = 12;
        inner-pad = 8;
      };

      colors = {
        background = "1e1e2eee";
        text = "cdd6f4ff";
        match = "f5c2e7ff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "f5c2e7ff";
        border = "b4befeff";
      };

      border = {
        width = 1;
        radius = 0;
      };

      dmenu = {
        exit-immediately-if-empty = "yes";
      };
    };
  };
}
