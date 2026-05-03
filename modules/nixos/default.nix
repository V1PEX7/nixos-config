{
  imports = [
    ./hardening
    ./hardware/amd.nix
    ./hardware/nvidia.nix
    ./hardware/audio.nix
    ./desktop
    ./networking.nix
    ./apps.nix
    ./dms.nix
    ./sandbox.nix
  ];
}
