{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.hardware.intel;
in
{
  options.modules.hardware.intel.enable = lib.mkEnableOption "Intel GPU support";

  config = lib.mkIf cfg.enable {
    boot.initrd.kernelModules = [ "i915" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };
}
