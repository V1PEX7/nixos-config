{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.getty.autologinUser = "xnp";

  modules = {
    hardware.amd.enable = true;
    hardware.audio.enable = true;
    desktop.enable = true;
    desktop.niri.enable = true;
    networking.enable = true;
    apps.enable = true;
    apps.gaming.enable = true;
    apps.docker.enable = false;
    sandbox.enable = true;

    hardening = {
      kernel.basic.enable = true;
      kernel.strict.enable = false;
      network.enable = true;
      modules.enable = true;
    };
  };

  system.stateVersion = "25.11";
}
