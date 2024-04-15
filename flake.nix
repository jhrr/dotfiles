{
  description = "~jhrr";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
      nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      nur.url = "github:nix-community/NUR";

      darwin = {
        url = "github:lnl7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      flake-compat = {
        url = "github:edolstra/flake-compat";
        flake = false;
      };

      flake-utils = {
        url = "github:numtide/flake-utils";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = {
    darwin,
    home-manager,
    nixpkgs,
    nur,
    ...
  }: {
    darwinConfigurations."paradise" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./hosts/paradise/darwin.nix
        home-manager.darwinModules.home-manager
        # {
        #   home-manager.users.jhrr = import ./home.nix;
        # }
      ];
      specialArgs = { inherit nixpkgs; };
    };

    darwinConfigurations."purgatory" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/purgatory/darwin.nix
        home-manager.darwinModules.home-manager
        # {
        #   home-manager.users.jhrr = import ./home.nix;
        # }
      ];
      specialArgs = { inherit nixpkgs; };
    };
  };
}
