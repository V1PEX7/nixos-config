{ pkgs, ... }:
let
  template = pkgs.writeText "matugen-theme.nix" ''
    generated = {
      bg = "{{colors.surface.default.hex}}";
      surface = "{{colors.surface_container.default.hex}}";
      fg = "{{colors.on_surface.default.hex}}";
      accent = "{{colors.primary.default.hex}}";
      hover = "{{colors.surface_container_high.default.hex}}";
      red = "{{colors.error.default.hex}}";
      green = "{{colors.tertiary.default.hex}}";
      yellow = "{{colors.secondary.default.hex}}";
      contrast = "#000000";
      shadow = "{{colors.shadow.default.hex}}";
      dim = "0.35";
      calMonth = "{{colors.on_surface.default.hex}}";
      calWeekdays = "{{colors.secondary.default.hex}}";
      calToday = "{{colors.primary.default.hex}}";

      hypr = {
        active_border = "rgba({{colors.primary.default.hex_stripped}}ff)";
        inactive_border = "rgba({{colors.surface_container_highest.default.hex_stripped}}aa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "{{colors.surface.default.hex}}";
        fg = "{{colors.on_surface.default.hex}}";
        selText = "{{colors.on_primary_container.default.hex}}";
        selBg = "{{colors.primary_container.default.hex}}";
        curText = "{{colors.surface.default.hex}}";
        curCursor = "{{colors.primary.default.hex}}";
        black = "{{colors.surface.default.hex}}";
        red = "{{colors.error.default.hex}}";
        green = "{{colors.tertiary.default.hex}}";
        yellow = "{{colors.secondary.default.hex}}";
        blue = "{{colors.primary.default.hex}}";
        magenta = "{{colors.secondary_container.default.hex}}";
        cyan = "{{colors.primary_container.default.hex}}";
        white = "{{colors.on_surface_variant.default.hex}}";
        brBlack = "{{colors.outline.default.hex}}";
        brRed = "{{colors.error_container.default.hex}}";
        brGreen = "{{colors.tertiary_container.default.hex}}";
        brYellow = "{{colors.secondary.default.hex}}";
        brBlue = "{{colors.primary_fixed.default.hex}}";
        brMagenta = "{{colors.secondary_fixed.default.hex}}";
        brCyan = "{{colors.primary_fixed_dim.default.hex}}";
        brWhite = "{{colors.on_surface.default.hex}}";
      };

      fuzzel = {
        bg = "{{colors.surface.default.hex_stripped}}ee";
        text = "{{colors.on_surface.default.hex_stripped}}ff";
        match = "{{colors.primary.default.hex_stripped}}ff";
        selection = "{{colors.surface_container_high.default.hex_stripped}}ff";
        selText = "{{colors.on_surface.default.hex_stripped}}ff";
        selMatch = "{{colors.primary.default.hex_stripped}}ff";
        border = "{{colors.primary.default.hex_stripped}}ff";
      };
    };
  '';

  matugenConfig = pkgs.writeText "matugen-config.toml" ''
    [config]

    [templates.nixtheme]
    input_path = "${template}"
    output_path = "/dev/stdout"
  '';
in
{
  home.packages = [
    (pkgs.writeShellScriptBin "mktheme" ''
      set -euo pipefail
      RAW="''${1:-$HOME/.config/wallpaper}"

      if [[ "$RAW" =~ ^# ]]; then
        exec ${pkgs.matugen}/bin/matugen color hex "$RAW" -m dark -c ${matugenConfig}
      else
        IMG="$(readlink -f "$RAW")"
        [ -f "$IMG" ] || { echo "Image not found: $IMG" >&2; exit 1; }
        exec ${pkgs.matugen}/bin/matugen image "$IMG" -m dark -c ${matugenConfig}
      fi
    '')
  ];
}
