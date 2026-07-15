{ config, lib, ... }:
let
  cfg = config.modules.desktop.hyprland;
in
{
  options.modules.desktop.hyprland.enable = lib.mkEnableOption "Hyprland compositor";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.gnome.gnome-keyring.enable = true;
  };
}
