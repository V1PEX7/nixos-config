{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.hardware.es8336;
in
{
  options.modules.hardware.es8336.enable = lib.mkEnableOption "ES8336 speaker fix";

  config = lib.mkIf cfg.enable {
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
  };
}
