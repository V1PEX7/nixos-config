{
  imports = [
    ./hardening
    ./hardware/amd.nix
    ./hardware/nvidia.nix
    ./hardware/intel.nix
    ./hardware/audio.nix
    ./desktop
    ./networking.nix
    ./apps.nix
    ./sandbox.nix
  ];
}
