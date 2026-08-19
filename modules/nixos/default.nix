{
  imports = [
    ./hardening
    ./hardware/amd.nix
    ./hardware/nvidia.nix
    ./hardware/intel.nix
    ./hardware/audio.nix
    ./hardware/es8336.nix
    ./desktop
    ./networking.nix
    ./apps.nix
  ];
}
