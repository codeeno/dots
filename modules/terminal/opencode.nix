{
  lib,
  pkgs,
  ...
}:
let
  # Pinned snapshot of github/awesome-copilot — skills from this repo are used via
  # programs.opencode.skills. Bump rev + hash to update.
  awesome-copilot = pkgs.fetchFromGitHub {
    owner = "github";
    repo = "awesome-copilot";
    rev = "63d08d51f792d53feec8c1c06897cee870e83c18";
    hash = "sha256-ZCyhl2F6oBj6FYNfPKfS1jpf7RI/OVHJQi1C7kpxDjo=";
  };
in
{
  programs.opencode = {
    enable = lib.mkDefault true;

    skills = {
      excalidraw-diagram-generator = "${awesome-copilot}/skills/excalidraw-diagram-generator";
    };

    settings = {
      model = "anthropic/claude-opus-4-7";
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
      # Anthropic is trying to disallow third-party apps like opencode. For now, changing the system prompt to not mention
      # that it is opencode seems to fix it. See: https://github.com/griffinmartin/opencode-claude-auth/issues/145
      mode = {
        plan = {
          prompt = "You are Claude Code, Anthropic's official CLI for Claude.";
        };
        build = {
          prompt = "You are Claude Code, Anthropic's official CLI for Claude.";
        };
      };
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
