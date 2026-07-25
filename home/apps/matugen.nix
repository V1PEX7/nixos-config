{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "wallpaper-color" ''
      set -euo pipefail
      RAW="''${1:-$HOME/.config/wallpaper}"
      IMG="$(${pkgs.coreutils}/bin/readlink -f "$RAW")"
      [ -e "$IMG" ] || { echo "No image: $IMG" >&2; exit 1; }
      exec ${pkgs.matugen}/bin/matugen image "$IMG" -m dark "$@"
    '')
  ];
}
