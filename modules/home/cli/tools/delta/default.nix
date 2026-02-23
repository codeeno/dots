{ config, lib, ... }:
let
  cfg = config.modules.cli.tools.delta;
in
{
  options.modules.cli.tools.delta = {
    enable = lib.mkEnableOption "delta diff viewer";
  };

  config = lib.mkIf cfg.enable {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        features = "decorations line-numbers";
      };
    };

    home.shellAliases = {
      diff = "delta --side-by-side";
    };
  };
}
