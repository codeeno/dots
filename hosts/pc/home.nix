{ lib, ... }:
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
  };

  # See: https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-sudo
  targets.genericLinux.gpu.enable = true;
  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "580.105.08";
    sha256 = "sha256-2cboGIZy8+t03QTPpp3VhHn6HQFiyMKMjRdiV2MpNHU=";
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
