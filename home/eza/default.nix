{ config, pkgs, ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."eza/theme.yaml".source = ./theme.yaml;
}
