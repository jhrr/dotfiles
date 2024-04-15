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

    # pre-commit-hooks = {
    #   url = "github:cachix/pre-commit-hooks.nix";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     flake-utils.follows = "flake-utils";
    #     flake-compat.follows = "flake-compat";
    #   };
    # };

    # devenv = {
    #   url = "github:cachix/devenv";
    #   inputs = {
    #     # nixpkgs.follows = "nixpkgs"; # TODO: Don't override so that the cache can be used?
    #     flake-compat.follows = "flake-compat";
    #     pre-commit-hooks.follows = "pre-commit-hooks";
    #   };
    # };
  };

  outputs = {
    darwin,
    home-manager,
    nixpkgs,
    nur,
    ...
  }: {
    homeManagerConfFor = config: {...}: {
      nixpkgs.overlays = [nur.overlay];
      imports = [config];
    };

    darwinConfigurations."paradise" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./hosts/paradise/darwin.nix
        home-manager.darwinModules.home-manager
        # {
        #   home-manager.users.jhrr = homeManagerConfFor ./home.nix;
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
        #   home-manager.users.jhrr = homeManagerConfFor ./home.nix;
        # }
      ];
      specialArgs = { inherit nixpkgs; };
    };
  };
}
