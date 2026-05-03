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
  options.modules.sandbox.enable = lib.mkEnableOption "system-level sandboxing support (AppArmor, bwrap)";

  config = lib.mkIf cfg.enable {
    # security.apparmor = {
    #   enable = true;
    #   killUnconfinedConfinables = true;
    #   packages = [ pkgs.apparmor-profiles ];
    # };

    environment.systemPackages = with pkgs; [
      bubblewrap
    ];
  };
}
