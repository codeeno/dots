{
  programs.eza = {
    enable = true;
  };

  xdg.configFile."eza/theme.yaml".source = ./theme.yaml;

  home.shellAliases = {
    ll = "eza --long --header --git --all";
    tree = "eza --tree --icons";
  };
}
