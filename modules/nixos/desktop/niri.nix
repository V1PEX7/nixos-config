{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.niri;
in
{
  options.modules.desktop.niri.enable = lib.mkEnableOption "Niri compositor";

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    environment.systemPackages = [
      pkgs.xwayland-satellite
    ];
  };
}
