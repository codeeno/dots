{ config, lib, ... }:
let
  cfg = config.modules.cli.tools.git;
in
{
  options.modules.cli.tools.git = {
    enable = lib.mkEnableOption "git version control";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = lib.mkDefault "Sebastian Kleboth";
          email = lib.mkDefault "sebastian@kleboth.de";
        };
        alias = {
          co = "checkout";
          st = "status";
          ci = "commit";
        };
        merge = {
          conflictStyle = "zdiff3";
        };
        pull = {
          rebase = false;
        };
        init = {
          defaultBranch = "main";
        };
      };
    };

    home.shellAliases = {
      gp = "git pull";
      groot = "cd $(git rev-parse --show-toplevel)";
    };
  };
}
