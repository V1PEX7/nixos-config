{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.hardening.modules;
in
{
  options.modules.hardening.modules.enable = lib.mkEnableOption "kernel module blacklist";

  config = lib.mkIf cfg.enable {
    boot.blacklistedKernelModules = [
      "parport"
      "parport_pc"
      "ppdev"

      "dccp"
      "sctp"
      "rds"
      "tipc"
      "can"
      "atm"

      "mac_hid"
      "mousedev"
      "pcspkr"
      "floppy"

      "snd_seq_dummy"
      "acpi_pad"

      "mtd"
      "cmdlinepart"
      "ofpart"
      "spi_nor"

      "8250_dw"

      "esp4"
      "esp6"
      "rxrpc"
    ];

    boot.extraModprobeConfig = ''
      install esp4 ${pkgs.coreutils}/bin/false
      install esp6 ${pkgs.coreutils}/bin/false
      install rxrpc ${pkgs.coreutils}/bin/false
    '';
  };
}
