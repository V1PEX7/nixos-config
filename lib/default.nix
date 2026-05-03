{ inputs, ... }:
{
  mkHost =
    {
      hostname,
      system ? "x86_64-linux",
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        outputs = inputs.self;
      };
      modules = [
        ../hosts/common
        ../hosts/${hostname}

        inputs.mango.nixosModules.mango

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            inherit inputs;
            outputs = inputs.self;
          };
          home-manager.users.xnp = {
            imports = [
              ../home
              inputs.mango.hmModules.mango
            ];
          };
        }
      ];
    };
}
