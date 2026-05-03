{ config, lib, ... }:
let
  cfg = config.modules.hardening.kernel.strict;
in
{
  options.modules.hardening.kernel.strict.enable = lib.mkEnableOption ''
    strict kernel hardening (ptrace, perf, bpf restrictions).
    May break games with anti-cheat, profilers, debuggers.
  '';

  config = lib.mkIf cfg.enable {
    boot.kernel.sysctl = {
      "kernel.yama.ptrace_scope" = 2;
      "kernel.perf_event_paranoid" = 3;
      "kernel.unprivileged_bpf_disabled" = 1;
    };
  };
}
