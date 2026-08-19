{ lib, config, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.settings = {
    theme = mkOption { type = types.str; };
    wallpaper = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/.config/wallpaper";
    };
    terminal = mkOption { type = types.str; };
    terminalOpacity = mkOption { type = types.str; };
    terminalPadding = mkOption { type = types.ints.unsigned; };
    gtkTheme = {
      name = mkOption { type = types.str; };
      package = mkOption { type = types.package; };
    };
    iconTheme = {
      name = mkOption { type = types.str; };
      package = mkOption { type = types.package; };
    };
    cursor = {
      name = mkOption { type = types.str; };
      package = mkOption { type = types.package; };
      size = mkOption { type = types.ints.positive; };
    };
    font = {
      family = mkOption { type = types.str; };
      familyPropo = mkOption { type = types.str; };
      size = mkOption { type = types.ints.positive; };
    };
    workspaces = mkOption { type = types.ints.positive; };
    rounding = mkOption { type = types.ints.unsigned; };
    border_size = mkOption { type = types.ints.unsigned; };
    blur = mkOption { type = types.bool; };
    animations = mkOption { type = types.bool; };
    gaps_in = mkOption { type = types.ints.unsigned; };
    gaps_out = mkOption { type = types.ints.unsigned; };
  };

  config._module.args.settings = config.settings;
}
