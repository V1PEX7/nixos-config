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
    desktop.enable = true;
    desktop.hyprland.enable = true;
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

      CARD="sofessx8336"

      CTRL_SWITCH="name='Headphone Switch'"
      CTRL_LEFT="name='Left Headphone Mixer Left DAC Switch'"
      CTRL_RIGHT="name='Right Headphone Mixer Right DAC Switch'"
      CTRL_VOL="name='Headphone Mixer Volume'"

      if $amixer -c "$CARD" cget "$CTRL_SWITCH" | grep -q "values=on"; then
        $amixer -c "$CARD" cset "$CTRL_LEFT" off
        $amixer -c "$CARD" cset "$CTRL_RIGHT" off
        $amixer -c "$CARD" cset "$CTRL_SWITCH" off
        echo "Speakers off"
      else
        # Reset toggle to wake up the ES8336 amplifier
        $amixer -c "$CARD" cset "$CTRL_LEFT" off
        $amixer -c "$CARD" cset "$CTRL_RIGHT" off
        $amixer -c "$CARD" cset "$CTRL_SWITCH" off

        sleep 0.1

        $amixer -c "$CARD" cset "$CTRL_LEFT" on
        $amixer -c "$CARD" cset "$CTRL_RIGHT" on
        $amixer -c "$CARD" cset "$CTRL_VOL" 8,8
        $amixer -c "$CARD" cset "$CTRL_SWITCH" on
        echo "Speakers on"
      fi
    '')
  ];

  system.stateVersion = "25.11";
}
