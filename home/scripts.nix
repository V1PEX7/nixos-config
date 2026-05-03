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

      ${pkgs.grim}/bin/grim -g "$GEOM" -t ppm /tmp/frozen-screenshot.ppm
      kill $WF_PID
      ${pkgs.satty}/bin/satty -f /tmp/frozen-screenshot.ppm &
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
      PICK=$(${pkgs.findutils}/bin/find "$WALL_DIR" -maxdepth 1 -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' -o -name '*.webp' \) -printf '%f\n' | sort | ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt "wall: ")
      [ -z "$PICK" ] && exit 0
      ${pkgs.procps}/bin/pkill swaybg || true
      ln -sf "$WALL_DIR/$PICK" "$HOME/.config/wallpaper"
      ${pkgs.swaybg}/bin/swaybg -i "$HOME/.config/wallpaper" -m fill &
      disown
    '')
  ];
}
