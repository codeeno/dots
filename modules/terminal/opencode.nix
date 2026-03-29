{ lib, ... }:
{
  programs.opencode = {
    enable = lib.mkDefault true;

    settings = {
      model = "github-copilot/claude-opus-4-6";
      plugin = [
        "oh-my-openagent"
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

  programs.zsh.shellAliases = {
    oc = "opencode";
  };
}
