{ pkgs, lib, ... }:
{
  imports = [
    ./nix.nix
    ./locale.nix
    ../../modules/nixos
  ];

  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.allowUnfreePackages = [
    "steam"
    "steam-unwrapped"
    "steam-run"
    "steam-sandboxed"
    "claude-code"
    "claude-sandboxed"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  services.printing.enable = false;
  services.speechd.enable = lib.mkForce false;
  services.geoclue2.enable = false;

  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [
      {
        users = [ "xnp" ];
        keepEnv = false;
        persist = true;
      }
    ];
  };

  security.protectKernelImage = true;

  programs.command-not-found.enable = false;
  systemd.oomd.enable = false;

  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
    DefaultTimeoutStartSec = "15s";
  };

  users.users.xnp = {
    isNormalUser = true;
    description = "xnp";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
    ];
  };
}
