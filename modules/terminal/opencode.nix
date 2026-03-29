{ lib, ... }:
{
  programs.opencode = {
    enable = lib.mkDefault true;

    settings = {
      model = "anthropic/claude-opus-4-6";
      mcp = {
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
        };
      };
      plugin = [
        "opencode-claude-auth"
        "superpowers@git+https://github.com/obra/superpowers.git"
      ];
    };
  };

  xdg.configFile."opencode/tui.json" = {
    text = builtins.toJSON {
      theme = "tokyonight";
      keybinds = {
        editor_open = "ctrl+g";
      };
    };
  };

  # TODO: remove this workaround once https://github.com/anomalyco/opencode/issues/16885 is fixed.
  # The migration gate checks for opencode.db but the stable channel uses opencode-stable.db,
  # so the "one time database migration" message appears on every startup.
  home.file.".local/share/opencode/opencode.db".text = "";

  home.sessionVariables = {
    OPENCODE_ENABLE_EXA = "1";
  };

  programs.zsh.shellAliases = {
    oc = "opencode";
  };
}
