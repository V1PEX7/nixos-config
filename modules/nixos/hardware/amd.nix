{ config, lib, ... }:
let
  cfg = config.modules.hardware.amd;
in
{
  options.modules.hardware.amd.enable = lib.mkEnableOption "AMD GPU support";

  config = lib.mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelParams = [ "amdgpu.cwsr_enable=0" ];

    hardware.amdgpu.overdrive.enable = true;

    services.xserver.videoDrivers = [ "amdgpu" ];
    environment.sessionVariables.AMD_VULKAN_ICD = "RADV";

    hardware.graphics.enable = true;
  };
}
