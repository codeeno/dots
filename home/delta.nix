{ config, pkgs, ... }:

{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "decorations line-numbers";
    };
  };
}
