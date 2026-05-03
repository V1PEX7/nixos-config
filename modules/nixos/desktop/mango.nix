{ config, lib, ... }:
let
  cfg = config.modules.desktop.mango;
in
{
  options.modules.desktop.mango.enable = lib.mkEnableOption "Mango compositor";

  config = lib.mkIf cfg.enable {
    programs.mango.enable = true;
  };
}
