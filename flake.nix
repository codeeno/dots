{
  description = "Home Manager configuration of eeno";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      darwin,
      ...
    }@inputs:
    let
      importModules = import ./lib/importModules.nix;
      homeModules = importModules ./modules/home ++ importModules ./modules/roles;
    in
    {
      darwinConfigurations = {
        "d434547@macbook" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            user = "d434547";
          };
          modules = [
            ./hosts/macbook/configuration.nix
            {
              nixpkgs.config.allowUnfree = true;
              nix.enable = false; # Let determinate handle Nix instead of nix-darwin
            }
          ];
        };
      };

      homeConfigurations = {
        "d434547@macbook" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = {
            inherit inputs;
            user = "d434547";
          };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = import ./overlays { inherit inputs; };
            }
          ]
          ++ homeModules
          ++ [
            ./hosts/macbook/home.nix
          ];
        };

        "eeno@chihiro" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs;
            user = "eeno";
          };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.config.nvidia.acceptLicense = true;
              nixpkgs.overlays = import ./overlays { inherit inputs; };
            }
          ]
          ++ homeModules
          ++ [
            ./hosts/chihiro/home.nix
          ];
        };

        "eeno@arch-wsl" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs;
            user = "eeno";
          };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.config.nvidia.acceptLicense = true;
              nixpkgs.overlays = import ./overlays { inherit inputs; };
            }
          ]
          ++ homeModules
          ++ [
            ./hosts/arch-wsl/home.nix
          ];
        };

      };
    };
}
