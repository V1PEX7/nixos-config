{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.apps;
in
{
  options.modules.apps = {
    enable = lib.mkEnableOption "system-level apps";
    gaming.enable = lib.mkEnableOption "Gaming (Steam + gamescope)";
    docker.enable = lib.mkEnableOption "Rootless Docker";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.zsh.enable = true;

        programs.git = {
          enable = true;
          config.init.defaultBranch = "main";
        };

        programs.nix-ld.enable = true;

        programs.localsend = {
          enable = true;
          openFirewall = true;
        };

        programs.throne = {
          enable = true;
          tunMode.enable = true;
        };
      }

      (lib.mkIf cfg.gaming.enable {
        programs.steam = {
          enable = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };

        services.lact.enable = true;

        environment.systemPackages = with pkgs; [
          # mangohud
          # goverlay
          # steam-run
        ];
      })

      (lib.mkIf cfg.docker.enable {

        virtualisation.docker.rootless = {
          enable = true;
          setSocketVariable = true;
          daemon.settings = {
            dns = [
              "9.9.9.9"
              "149.112.112.112"
            ];
          };
        };
      })
    ]
  );
}
