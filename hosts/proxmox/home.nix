{ lib, ... }:
{
  imports = [
    ../../modules/common/terminal
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "25.05";
}
