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
    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      lazyvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."eeno" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            nixpkgs.config.allowUnfree = true;
          }
          ./home.nix
        ];
        extraSpecialArgs = {
          inherit lazyvim;
        };
      };
    };
}
