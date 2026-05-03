{ config, lib, ... }:
let
  cfg = config.modules.dms;
in
{
  options.modules.dms.enable = lib.mkEnableOption "DMS shell";

  config = lib.mkIf cfg.enable {
    programs.dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      enableDynamicTheming = true;
      enableSystemMonitoring = true;
      enableVPN = false;
      enableAudioWavelength = true;
      enableCalendarEvents = false;
      enableClipboardPaste = true;
    };

    programs.dsearch = {
      enable = true;
      systemd.enable = true;
    };
  };
}
