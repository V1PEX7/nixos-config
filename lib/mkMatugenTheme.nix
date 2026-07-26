{ pkgs }:
{
  seed,
  mode ? "dark",
}:
let
  lib = pkgs.lib;
  template = ../home/matugen-template.nix.template;

  built =
    pkgs.runCommand "matugen-theme-${mode}-${lib.removePrefix "#" seed}"
      { nativeBuildInputs = [ pkgs.matugen ]; }
      ''
        cat > config.toml <<EOF
        [config]

        [templates.nixtheme]
        input_path = "${template}"
        output_path = "$PWD/theme.nix"
        EOF

        matugen color hex "${seed}" -m ${mode} --config config.toml
        cp theme.nix "$out"
      '';
in
import built
