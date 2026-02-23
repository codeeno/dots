{ lib, ... }:
{
  programs.claude-code = {
    enable = lib.mkDefault true;
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
}
