{ lib, ... }:
{
  programs.opencode = {
    enable = lib.mkDefault true;

    settings = {
      model = "github-copilot/claude-opus-4-6";
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
}
