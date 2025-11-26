{
  description = "~jhrr";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    darwin,
    flake-utils,
    home-manager,
    nixpkgs,
    nur,
    ...
  }:
    let
      homeManagerConf = config: {...}: {
        nixpkgs.overlays = [nur.overlay];
        imports = [config];
      };
    in {
      darwinConfigurations."paradise" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/paradise/darwin.nix

          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jhrr = homeManagerConf ./hosts/paradise/home.nix;
          }
        ];
        specialArgs = { inherit nixpkgs; };
      };

      darwinConfigurations."purgatory" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/purgatory/darwin.nix

          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jhrr = homeManagerConf ./hosts/purgatory/home.nix;
          }
        ];
        specialArgs = { inherit nixpkgs; };
      };
  };
}
