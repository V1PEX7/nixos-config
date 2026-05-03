{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.power-profiles-daemon.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="BAT0", \
      RUN+="${pkgs.coreutils}/bin/chgrp battery_ctl /sys%p/charge_control_end_threshold", \
      RUN+="${pkgs.coreutils}/bin/chmod g+w /sys%p/charge_control_end_threshold"
  '';

  services.getty.autologinUser = "xnp";

  modules = {
    hardware.audio.enable = true;
    desktop.enable = true;
    desktop.mango.enable = true;
    dms.enable = false;
    networking.enable = true;
    apps.enable = true;
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
