{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.roles.development;
in
{
  options.modules.roles.development = {
    enable = lib.mkEnableOption "development tools and languages";
  };

  config = lib.mkIf cfg.enable {
    modules = {
      cli = {
        tools = {
          git.enable = true;
          delta.enable = true;
          lazygit.enable = true;
          mise.enable = true;
        };
        editors.lazyvim.enable = true;
      };
    };

    home = {
      packages = with pkgs; [
        gh
        glab
        go
        just
        postgresql
        redis
        uv
      ];

      sessionVariables = {
        PGHOST = "localhost";
      };

      sessionPath = [
        "$HOME/go/bin"
      ];
    };
  };
}
