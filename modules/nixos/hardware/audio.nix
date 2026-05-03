{ config, lib, ... }:
let
  cfg = config.modules.hardware.audio;
in
{
  options.modules.hardware.audio.enable = lib.mkEnableOption "PipeWire audio";

  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = false;
      alsa.support32Bit = false;
      pulse.enable = true;
      jack.enable = false;

      extraConfig.pipewire."92-clock-rates" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [
            44100
            48000
            88200
            96000
            176400
            192000
          ];
        };
      };
    };
  };
}
