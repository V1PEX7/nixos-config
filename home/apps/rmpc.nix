{ config, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    extraConfig = ''
      audio_output {
              type            "pipewire"
              name            "PipeWire Output"
              auto_resample   "no"
              auto_format     "no"
              auto_channels   "no"
            }
            mixer_type      "none"
    '';
  };

  services.mpd-mpris.enable = true;

  programs.rmpc = {
    enable = true;
    config = ''
      (
        address: "127.0.0.1:6600",
      )
    '';
  };
}
