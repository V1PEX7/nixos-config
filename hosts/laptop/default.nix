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
    #apps.vm.enable = true;
    sandbox.enable = true;

    hardening = {
      kernel.basic.enable = true;
      kernel.strict.enable = true;
      network.enable = true;
      modules.enable = true;
    };
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "fix-speakers" ''
      amixer="${pkgs.alsa-utils}/bin/amixer"
      current=$($amixer -c 0 cget numid=30 | grep ': values=' | cut -d= -f2)
      if [ "$current" = "on" ]; then
        $amixer -c 0 cset numid=70 off
        $amixer -c 0 cset numid=72 off
        $amixer -c 0 cset numid=30 off
        echo "Speakers off"
      else
        $amixer -c 0 cset numid=70 on
        $amixer -c 0 cset numid=72 on
        $amixer -c 0 cset numid=2 8,8
        $amixer -c 0 cset numid=30 on
        echo "Speakers on"
      fi
    '')
  ];

  system.stateVersion = "25.11";
}
