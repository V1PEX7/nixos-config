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
      green = "{{colors.green.default.hex}}";
      yellow = "{{colors.yellow.default.hex}}";
      contrast = "#000000";
      shadow = "{{colors.shadow.default.hex}}";
      dim = "0.35";
      calMonth = "{{colors.on_surface.default.hex}}";
      calWeekdays = "{{colors.yellow.default.hex}}";
      calToday = "{{colors.primary.default.hex}}";

      hypr = {
        active_border = "rgba({{colors.primary.default.hex_stripped}}ff)";
        inactive_border = "rgba({{colors.surface_container_highest.default.hex_stripped}}aa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "{{colors.surface.default.hex}}";
        fg = "{{colors.on_surface.default.hex}}";
        selText = "{{colors.on_surface.default.hex}}";
        selBg = "{{colors.surface_container_high.default.hex}}";
        curText = "{{colors.surface.default.hex}}";
        curCursor = "{{colors.primary.default.hex}}";

        black = "{{colors.surface_container.default.hex}}";
        red = "{{colors.error.default.hex}}";
        green = "{{colors.green.default.hex}}";
        yellow = "{{colors.yellow.default.hex}}";
        blue = "{{colors.primary.default.hex}}";
        magenta = "{{colors.tertiary.default.hex}}";
        cyan = "{{colors.secondary.default.hex}}";
        white = "{{colors.on_surface_variant.default.hex}}";

        brBlack = "{{colors.outline.default.hex}}";
        brRed = "{{colors.error.default.hex}}";
        brGreen = "{{colors.green.default.hex}}";
        brYellow = "{{colors.yellow.default.hex}}";
        brBlue = "{{colors.primary_fixed.default.hex}}";
        brMagenta = "{{colors.tertiary_fixed.default.hex}}";
        brCyan = "{{colors.secondary_fixed.default.hex}}";
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

    [config.custom_colors.green]
    color = "#a8c47a"
    blend = true

    [config.custom_colors.yellow]
    color = "#e8c08e"
    blend = true

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
