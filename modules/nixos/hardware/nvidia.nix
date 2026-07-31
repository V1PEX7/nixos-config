{ config, lib, ... }:
let
  cfg = config.modules.hardware.nvidia;
in
{
  options.modules.hardware.nvidia.enable = lib.mkEnableOption "NVIDIA GPU support";

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
    };

    hardware.graphics.enable = true;
  };
}
