{ config, pkgs, lib, ... }:

{
  programs.delta = {
    enable = lib.mkDefault true;
    enableGitIntegration = true;
    options = {
      features = "decorations line-numbers";
    };
  };
}
