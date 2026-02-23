{ config, lib, ... }:
let
  cfg = config.modules.cli.ai.claude-code;
in
{
  options.modules.cli.ai.claude-code = {
    enable = lib.mkEnableOption "claude code AI assistant";
  };

  config = lib.mkIf cfg.enable {
    programs.claude-code = {
      enable = true;
      settings = {
        theme = "dark";

        permissions = {
          allow = [
            # Web
            "WebFetch"
            "WebSearch"

            # Read
            "Read"
          ];
        };
      };
    };

    programs.zsh.shellAliases = {
      cc = "claude";
    };
  };
}
