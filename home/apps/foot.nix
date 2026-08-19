{
  pkgs,
  theme,
  settings,
  strip,
  ...
}:
let
  t = theme;
  s = settings;
in
{
  programs.foot = {
    enable = true;
    package = pkgs.foot;
    settings = {
      main = {
        font = "${s.font.family}:size=${toString s.font.size}";
        shell = "zsh";
        term = "foot";
        pad = "${toString s.terminalPadding}x${toString s.terminalPadding}";
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
        alpha = s.terminalOpacity;
        blur = if s.blur then "yes" else "no";
        background = strip t.term.bg;
        foreground = strip t.term.fg;

        selection-foreground = strip t.term.selText;
        selection-background = strip t.term.selBg;

        regular0 = strip t.term.black;
        regular1 = strip t.term.red;
        regular2 = strip t.term.green;
        regular3 = strip t.term.yellow;
        regular4 = strip t.term.blue;
        regular5 = strip t.term.magenta;
        regular6 = strip t.term.cyan;
        regular7 = strip t.term.white;

        bright0 = strip t.term.brBlack;
        bright1 = strip t.term.brRed;
        bright2 = strip t.term.brGreen;
        bright3 = strip t.term.brYellow;
        bright4 = strip t.term.brBlue;
        bright5 = strip t.term.brMagenta;
        bright6 = strip t.term.brCyan;
        bright7 = strip t.term.brWhite;
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
