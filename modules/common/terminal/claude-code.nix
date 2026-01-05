{
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
}
