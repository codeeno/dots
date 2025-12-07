{ pkgs, lib, ... }:
let
  flakePath = "~/projects/dots";
  flakeConfig = "eeno@pc";
in
{
  imports = [
    ../../modules/common/terminal
    ../../modules/common/programs/kitty.nix
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = "eeno";
    homeDirectory = "/home/eeno";
    stateVersion = "25.05";
    packages = with pkgs; [ traceroute ];
  };

  # See: https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-sudo
  targets.genericLinux.gpu.enable = true;
  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "580.95.05";
    sha256 = "sha256-hJ7w746EK5gGss3p8RwTA9VPGpp2lGfk5dlhsv4Rgqc=";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh.shellAliases = {
      hm = "home-manager switch --flake ${flakePath}#${flakeConfig}";
      hmd = "home-manager switch --flake ${flakePath}#${flakeConfig} --dry-run";
    };
  };

}
