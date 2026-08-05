{
  config,
  pkgs,
  theme,
  settings,
  ...
}:
let
  t = theme;
  s = settings;
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    plugins = [ pkgs.rofi-calc ];
    terminal = "foot";

    extraConfig = {
      modi = "drun,calc,window";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      drun-display-format = "{name}";
      disable-history = false;
    };

    theme = {
      "*" = {
        font = "JetBrains Mono Nerd Font 12";

        bg0 = mkLiteral t.bg;
        bg1 = mkLiteral t.surface;
        bg-selected = mkLiteral t.hover;

        fg0 = mkLiteral t.fg;
        accent-color = mkLiteral t.accent;
        urgent-color = mkLiteral t.yellow;

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";

        margin = mkLiteral "0";
        padding = mkLiteral "0";
        spacing = mkLiteral "0";
      };

      "window" = {
        location = mkLiteral "center";
        width = mkLiteral "480";
        background-color = mkLiteral "@bg0";
        border = mkLiteral "0px";
        border-radius = mkLiteral "${toString s.rounding}px";
      };

      "inputbar" = {
        spacing = mkLiteral "8px";
        padding = mkLiteral "8px";
        background-color = mkLiteral "@bg1";
      };

      "prompt, entry, element-icon, element-text" = {
        vertical-align = mkLiteral "0.5";
      };

      "prompt" = {
        text-color = mkLiteral "@accent-color";
      };

      "textbox" = {
        padding = mkLiteral "8px";
        background-color = mkLiteral "@bg1";
      };

      "listview" = {
        padding = mkLiteral "4px 0";
        lines = mkLiteral "8";
        columns = mkLiteral "1";
        fixed-height = mkLiteral "false";
      };

      "element" = {
        padding = mkLiteral "8px";
        spacing = mkLiteral "8px";
        border-radius = mkLiteral "${toString s.rounding}px";
      };

      "element normal normal" = {
        text-color = mkLiteral "@fg0";
      };

      "element normal urgent" = {
        text-color = mkLiteral "@urgent-color";
      };

      "element normal active" = {
        text-color = mkLiteral "@accent-color";
      };

      "element alternate active" = {
        text-color = mkLiteral "@accent-color";
      };

      # Subtle dark selection background with highlighted text
      "element selected normal, element selected active" = {
        background-color = mkLiteral "@bg-selected";
        text-color = mkLiteral "@accent-color";
      };

      "element selected urgent" = {
        background-color = mkLiteral "@urgent-color";
        text-color = mkLiteral "@bg0";
      };

      "element-icon" = {
        size = mkLiteral "0.8em";
      };

      "element-text" = {
        text-color = mkLiteral "inherit";
      };
    };
  };
}
