{ lib, pkgs, ... }:
{
  programs.firefox = {
    enable = lib.mkDefault true;
    package = pkgs.firefox-bin;
  };
}
