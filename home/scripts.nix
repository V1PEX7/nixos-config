{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "freeze-screenshot-satty" ''
      ${pkgs.wayfreeze}/bin/wayfreeze &
      WF_PID=$!
      sleep 0.1
      GEOM=$(${pkgs.slurp}/bin/slurp) || { kill $WF_PID; exit 1; }

      if [ -z "$GEOM" ]; then
        kill $WF_PID
        exit 0
      fi

      SHOT=$(${pkgs.coreutils}/bin/mktemp --suffix=.ppm)
      trap '${pkgs.coreutils}/bin/rm -f "$SHOT"' EXIT

      ${pkgs.grim}/bin/grim -g "$GEOM" -t ppm "$SHOT"
      kill $WF_PID
      ${pkgs.satty}/bin/satty -f "$SHOT"
    '')

    (pkgs.writeShellScriptBin "freeze-screenshot" ''
      ${pkgs.wayfreeze}/bin/wayfreeze &
      WF_PID=$!
      sleep 0.1
      GEOM=$(${pkgs.slurp}/bin/slurp) || { kill $WF_PID; exit 1; }
      if [ -z "$GEOM" ]; then
        kill $WF_PID
        exit 0
      fi
      ${pkgs.grim}/bin/grim -g "$GEOM" - | ${pkgs.wl-clipboard}/bin/wl-copy
      kill $WF_PID
    '')

    (pkgs.writeShellScriptBin "wallpicker" ''
      WALL_DIR="''${1:-$HOME/Pictures/Wallpapers}"
      [ -d "$WALL_DIR" ] || { echo "No wallpaper directory: $WALL_DIR"; exit 1; }

      PICK=$(
        ${pkgs.findutils}/bin/find "$WALL_DIR" -maxdepth 1 -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' -o -name '*.webp' \) -printf '%f\n' | sort | while read -r img; do
          printf "%s\0icon\x1f%s/%s\n" "$img" "$WALL_DIR" "$img"
        done | ${pkgs.rofi}/bin/rofi -dmenu -i -show-icons -p "Wallpaper" -theme-str '
          window { width: 920px; }
          listview { columns: 4; lines: 2; spacing: 12px; cycle: true; fixed-columns: true; }
          element { orientation: vertical; padding: 12px; spacing: 8px; }
          element-icon { size: 160px; horizontal-align: 0.5; }
          element-text { horizontal-align: 0.5; vertical-align: 0.5; }
        '
      )

      [ -z "$PICK" ] && exit 0

      ${pkgs.procps}/bin/pkill swaybg || true
      ln -sf "$WALL_DIR/$PICK" "$HOME/.config/wallpaper"
      ${pkgs.swaybg}/bin/swaybg -i "$HOME/.config/wallpaper" -m fill &
      disown
    '')

    (pkgs.writeShellScriptBin "hypr-zoom" ''
      set -euo pipefail
      exec 200>"''${XDG_RUNTIME_DIR:-/tmp}/hypr-zoom.lock"
      flock 200

      step="0.5"; min="1"; max="10"
      cur=$(${pkgs.hyprland}/bin/hyprctl -j getoption cursor:zoom_factor | ${pkgs.jq}/bin/jq -r '.float')
      case "''${1:-}" in
        in)    new=$(${pkgs.gawk}/bin/awk -v c="$cur" -v s="$step" -v m="$max" 'BEGIN{v=c+s; print (v>m?m:v)}') ;;
        out)   new=$(${pkgs.gawk}/bin/awk -v c="$cur" -v s="$step" -v m="$min" 'BEGIN{v=c-s; print (v<m?m:v)}') ;;
        reset) new="1" ;;
        *) echo "usage: hypr-zoom {in|out|reset}" >&2; exit 1 ;;
      esac
      ${pkgs.hyprland}/bin/hyprctl eval "hl.config({ cursor = { zoom_factor = $new } })"
    '')
  ];
}
