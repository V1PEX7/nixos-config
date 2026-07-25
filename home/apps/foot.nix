{ pkgs, ... }:
let
  t_full = import ../theme.nix { inherit pkgs; };
  t = t_full.theme;
in
{
  programs.foot = {
    enable = true;
    package = pkgs.foot;
    settings = {
      main = {
        font = "JetBrains Mono Nerd Font:size=12";
        shell = "zsh";
        term = "foot";
        pad = "25x25";
      };

      cursor = {
        style = "beam";
        blink = "yes";
        blink-rate = 500;
        beam-thickness = "1.5";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      scrollback = {
        lines = 10000;
      };

      "colors-dark" = {
        alpha = "0.9";
        background = builtins.substring 1 6 t.term.bg;
        foreground = builtins.substring 1 6 t.term.fg;

        selection-foreground = builtins.substring 1 6 t.term.selText;
        selection-background = builtins.substring 1 6 t.term.selBg;

        regular0 = builtins.substring 1 6 t.term.black;
        regular1 = builtins.substring 1 6 t.term.red;
        regular2 = builtins.substring 1 6 t.term.green;
        regular3 = builtins.substring 1 6 t.term.yellow;
        regular4 = builtins.substring 1 6 t.term.blue;
        regular5 = builtins.substring 1 6 t.term.magenta;
        regular6 = builtins.substring 1 6 t.term.cyan;
        regular7 = builtins.substring 1 6 t.term.white;

        bright0 = builtins.substring 1 6 t.term.brBlack;
        bright1 = builtins.substring 1 6 t.term.brRed;
        bright2 = builtins.substring 1 6 t.term.brGreen;
        bright3 = builtins.substring 1 6 t.term.brYellow;
        bright4 = builtins.substring 1 6 t.term.brBlue;
        bright5 = builtins.substring 1 6 t.term.brMagenta;
        bright6 = builtins.substring 1 6 t.term.brCyan;
        bright7 = builtins.substring 1 6 t.term.brWhite;
      };

      key-bindings = {
        scrollback-up-half-page = "Control+u";
        scrollback-down-half-page = "Control+d";
        clipboard-copy = "Control+Shift+c XF86Copy";
        clipboard-paste = "Control+v XF86Paste";
        search-start = "Control+Shift+f";
      };
    };
  };
}
