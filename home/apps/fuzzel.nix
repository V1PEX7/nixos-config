{ ... }:
let
  t = import ../theme.nix;
in
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
        background = t.fuzzel.bg;
        text = t.fuzzel.text;
        match = t.fuzzel.match;
        selection = t.fuzzel.selection;
        selection-text = t.fuzzel.selText;
        selection-match = t.fuzzel.selMatch;
        border = t.fuzzel.border;
      };

      border = {
        width = 1;
        radius = 5;
      };

      dmenu = {
        exit-immediately-if-empty = "yes";
      };
    };
  };
}
