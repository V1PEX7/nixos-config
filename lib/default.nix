{ inputs, ... }:
{
  mkHost =
    {
      hostname,
      system ? "x86_64-linux",
      username ? "xnp",
      repoPath ? "/home/${username}/nixos-config",
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs username repoPath;
        outputs = inputs.self;
      };
      modules = [
        ../hosts/common
        ../hosts/${hostname}

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.overwriteBackup = true;
          home-manager.extraSpecialArgs = {
            inherit inputs username repoPath;
            outputs = inputs.self;
          };
          home-manager.users.${username} = {
            imports = [
              ../home
            ];
          };
        }
      ];
    };
}
