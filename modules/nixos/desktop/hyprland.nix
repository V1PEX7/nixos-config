{ config, lib, ... }:
let
  cfg = config.modules.desktop.hyprland;
in
{
  options.modules.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland compositor";

    monitors = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          freeformType = lib.types.attrsOf (
            lib.types.oneOf [
              lib.types.str
              lib.types.number
              lib.types.bool
            ]
          );
          options.output = lib.mkOption {
            type = lib.types.str;
            description = "Connector name, e.g. DP-1";
          };
          options.workspaces = lib.mkOption {
            type = lib.types.listOf lib.types.int;
            default = [ ];
            description = "Workspaces pinned to this output";
          };
        }
      );
      default = [ ];
      description = "Hyprland monitor descriptions for this host";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    security.pam.services.hyprlock = { };
  };
}
