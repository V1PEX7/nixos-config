{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  modules = {
    hardware.amd.enable = true;
    hardware.audio.enable = true;
    desktop.enable = true;
    desktop.hyprland.enable = true;
    desktop.hyprland.monitors = [
      {
        output = "DP-1";
        mode = "2560x1440@180";
        position = "0x0";
        scale = "1";
        vrr = 1;
        workspaces = [
          1
          2
          3
          4
          5
          6
        ];
      }
      {
        output = "DP-2";
        mode = "1920x1080@240";
        position = "-1920x360";
        scale = "1";
        workspaces = [
          7
          8
          9
        ];
      }
    ];
    networking.enable = true;
    apps.enable = true;
    apps.gaming.enable = true;
    apps.docker.enable = false;

    hardening = {
      kernel.basic.enable = true;
      kernel.strict.enable = false;
      network.enable = true;
      modules.enable = true;
    };
  };

  system.stateVersion = "26.11";
}
