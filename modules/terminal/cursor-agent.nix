{ pkgs, ... }:
{
  home.packages = [ pkgs.cursor-cli ];

  programs.zsh.shellAliases = {
    ca = "cursor-agent";
  };
}
