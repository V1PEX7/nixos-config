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
    vm.enable = lib.mkEnableOption "VM stack (libvirt + virt-manager)";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.zsh.enable = true;

        programs.git = {
          enable = true;
          config.init.defaultBranch = "main";
        };

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

        # steam is sandboxed and declared in home/sandbox.nix

        programs.gamescope.enable = true;

        services.lact.enable = true;

        environment.systemPackages = with pkgs; [
          # mangohud
          # goverlay
        ];

        hardware.graphics.enable32Bit = true;
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

      (lib.mkIf cfg.vm.enable {
        programs.virt-manager.enable = true;
        virtualisation.libvirtd.enable = true;
        virtualisation.spiceUSBRedirection.enable = true;

        users.users.xnp.extraGroups = [
          "libvirtd"
          "kvm"
        ];

        boot.kernel.sysctl = {
          "net.ipv4.ip_forward" = 1;
        };

        networking.firewall.trustedInterfaces = [ "virbr0" ];

        networking.nat = {
          enable = true;
          internalInterfaces = [ "virbr0" ];
          externalInterface = "throne-tun";
          internalIPs = [ "192.168.122.0/24" ];
        };

        networking.localCommands = ''
          ${pkgs.iproute2}/bin/ip rule del to 192.168.122.0/24 lookup main priority 10 2>/dev/null || true
          ${pkgs.iproute2}/bin/ip rule add to 192.168.122.0/24 lookup main priority 10
        '';
      })
    ]
  );
}
