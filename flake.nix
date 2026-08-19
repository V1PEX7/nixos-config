{
  description = "NixOS configuration (desktop + laptop)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      myLib = import ./lib { inherit inputs; };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        desktop = myLib.mkHost { hostname = "desktop"; };
        laptop = myLib.mkHost { hostname = "laptop"; };
      };

      formatter.${system} = pkgs.nixfmt-tree;

      checks.${system} = nixpkgs.lib.mapAttrs (
        _: host: host.config.system.build.toplevel
      ) self.nixosConfigurations;
    };
}
