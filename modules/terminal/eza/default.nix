{
  config,
  lib,
  ...
}:
{
  programs.eza = {
    enable = lib.mkDefault true;
  };

  xdg.configFile."eza/theme.yaml".source = ./theme.yaml;

  home.sessionVariables.EZA_CONFIG_DIR = "${config.xdg.configHome}/eza";
  home.shellAliases = {
    ll = "eza --long --header --git --all";
    tree = "eza --tree --icons";
  };
}
