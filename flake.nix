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
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      darwin,
      ...
    }@inputs:
    {
      darwinConfigurations = {
        "d434547@macbook" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
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
          extraSpecialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
            }
            ./hosts/macbook/home.nix
          ];
        };

        "eeno@pc" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.config.nvidia.acceptLicense = true;
            }
            ./hosts/pc/home.nix
          ];
        };
      };
    };
}
