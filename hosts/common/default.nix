{ pkgs, ... }:
{
  imports = [
    ./nix.nix
    ./locale.nix
    ../../modules/nixos
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  services.printing.enable = false;
  services.speechd.enable = false;

  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [
      {
        users = [ "xnp" ];
        keepEnv = true;
        persist = true;
      }
    ];
  };

  security.protectKernelImage = true;

  documentation.enable = false;
  documentation.nixos.enable = false;
  documentation.man.enable = false;
  programs.command-not-found.enable = false;
  systemd.oomd.enable = false;

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
