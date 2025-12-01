{ lib, ... }:
{
  imports = [
    ../../modules/common/terminal
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "25.05";
  };

  programs = {
    home-manager.enable = true;
  };
}
