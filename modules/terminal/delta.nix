{
  lib,
  ...
}:

{
  programs.delta = {
    enable = lib.mkDefault true;
    enableGitIntegration = true;
    options = {
      features = "decorations line-numbers";
    };
  };

  home.shellAliases = {
    diff = "delta --side-by-side";
  };
}
