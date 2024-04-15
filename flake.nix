{
  description = "~jhrr";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
      nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs";

      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      flake-compat = {
        url = "github:edolstra/flake-compat";
        flake = false;
      };
      flake-utils = {
        url = "github:numtide/flake-utils";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { self, nixpkgs, home-manager, darwin }: {
    darwinConfigurations."paradise" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./hosts/paradise/default.nix
      ];
    };

    darwinConfigurations."purgatory" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./hosts/purgatory/default.nix
      ];
    };
  };
}
