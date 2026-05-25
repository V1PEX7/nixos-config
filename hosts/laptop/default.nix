{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.power-profiles-daemon.enable = true;

  services.getty.autologinUser = "xnp";

  modules = {
    hardware.audio.enable = true;
    desktop.enable = true;
    desktop.mango.enable = true;
    networking.enable = true;
    apps.enable = true;
    apps.vm.enable = true;
    sandbox.enable = true;

    hardening = {
      kernel.basic.enable = true;
      kernel.strict.enable = true;
      network.enable = true;
      modules.enable = true;
    };
  };

  system.stateVersion = "25.11";
}
