{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.sandbox;
in
{
  options.modules.sandbox.enable = lib.mkEnableOption "system-level sandboxing support (bwrap)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bubblewrap
    ];
  };
}
