{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.power-profiles-daemon.enable = true;

  modules = {
    hardware.audio.enable = true;
    hardware.intel.enable = true;
    hardware.es8336.enable = true;
    desktop.enable = true;
    desktop.hyprland.enable = true;
    desktop.hyprland.monitors = [
      {
        output = "eDP-1";
        mode = "2160x1440@60";
        position = "auto";
        scale = "1";
      }
    ];
    networking.enable = true;
    apps.enable = true;
    apps.vm.enable = true;
    apps.gaming.enable = true;

    hardening = {
      kernel.basic.enable = true;
      kernel.strict.enable = true;
      network.enable = true;
      modules.enable = true;
    };
  };

  system.stateVersion = "26.11";
}
