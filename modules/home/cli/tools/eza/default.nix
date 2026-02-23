{ config, lib, ... }:
let
  cfg = config.modules.cli.tools.eza;
in
{
  options.modules.cli.tools.eza = {
    enable = lib.mkEnableOption "eza modern ls replacement";
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
    };

    xdg.configFile."eza/theme.yaml".source = ./theme.yaml;

    home = {
      shellAliases = {
        ll = "eza --long --header --git --all";
        tree = "eza --tree --icons";
      };

      sessionVariables.EZA_CONFIG_DIR = "${config.xdg.configHome}/eza";
    };
  };
}
