{
  imports = [
    ./hardening
    ./hardware/amd.nix
    ./hardware/nvidia.nix
    ./hardware/audio.nix
    ./desktop
    ./networking.nix
    ./vpn.nix
    ./apps.nix
    ./sandbox.nix
  ];
}
