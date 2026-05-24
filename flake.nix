{
  description = "NixOS configuration (desktop + laptop)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      myLib = import ./lib { inherit inputs; };
    in
    {
      nixosConfigurations = {
        desktop = myLib.mkHost { hostname = "desktop"; };
        laptop = myLib.mkHost { hostname = "laptop"; };
      };
    };
}
