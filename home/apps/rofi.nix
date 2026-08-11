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

  hyprlandWindowMode = pkgs.writeShellScript "rofi-hyprland-window-mode" ''
    if [ -n "''${1:-}" ] || [ "''${ROFI_RETV:-0}" -ne 0 ]; then
      if [ -n "''${ROFI_INFO:-}" ]; then
        ADDR="''${ROFI_INFO}"
        (${pkgs.coreutils}/bin/sleep 0.02 && ${pkgs.hyprland}/bin/hyprctl dispatch "hl.dsp.focus({ window = 'address:$ADDR' })") >/dev/null 2>&1 &
      fi
      exit 0
    fi

    ${pkgs.hyprland}/bin/hyprctl clients -j | ${pkgs.jq}/bin/jq -r '
      [.[] | select(.mapped == true)]
      | sort_by(if (.workspace.id // 0) > 0 then .workspace.id else 999999 end, (.class // ""), (.title // ""))
      | (
          (map(.focusHistoryID == 0) | index(true)) as $active_idx
          | select($active_idx != null)
          | "\u0000active\u001f\($active_idx)"
        ),
        (
          .[]
          | "[\(.workspace.name // "")]  \(.class // "")  —  \((.title // "") | gsub("\n"; " "))\u0000info\u001f\(.address)\u001ficon\u001f\((.class // "") | ascii_downcase)"
        )
    '
  '';
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    plugins = [ pkgs.rofi-calc ];
    terminal = "foot";

    extraConfig = {
      modi = "drun,calc,window:${hyprlandWindowMode}";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      drun-display-format = "{name}";
      disable-history = false;

      run-command = "uwsm app -- {cmd}";
      drun-launch = "uwsm app -- {cmd}";
    };

    theme = {
      "*" = {
        font = "JetBrains Mono Nerd Font 12";

        bg0 = mkLiteral t.bg;
        bg1 = mkLiteral t.surface;
        bg-selected = mkLiteral t.hover;

        fg0 = mkLiteral t.fg;
        accent-color = mkLiteral t.accent;
        active-color = mkLiteral t.fg; # currently selected window
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

      "element normal active, element alternate active" = {
        text-color = mkLiteral "@active-color";
      };

      "element selected normal" = {
        background-color = mkLiteral "@bg-selected";
        text-color = mkLiteral "@accent-color";
      };

      "element selected active" = {
        background-color = mkLiteral "@bg-selected";
        text-color = mkLiteral "@active-color";
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
