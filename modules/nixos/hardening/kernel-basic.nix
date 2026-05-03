{ config, lib, ... }:
let
  cfg = config.modules.hardening.kernel.basic;
in
{
  options.modules.hardening.kernel.basic.enable = lib.mkEnableOption "basic kernel hardening (safe for games)";

  config = lib.mkIf cfg.enable {
    boot.kernel.sysctl = {
      "kernel.dmesg_restrict" = 1;
      "kernel.kptr_restrict" = 2;
      "kernel.sysrq" = 0;
      "kernel.randomize_va_space" = 2;

      "fs.protected_hardlinks" = 1;
      "fs.protected_symlinks" = 1;
      "fs.protected_fifos" = 2;
      "fs.protected_regular" = 2;
      "fs.suid_dumpable" = 0;
    };

    security.pam.loginLimits = [
      {
        domain = "*";
        item = "core";
        type = "hard";
        value = "0";
      }
    ];
  };
}
