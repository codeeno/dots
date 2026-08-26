{ lib, ... }:
let
  # Compact cursor-acp model list from `open-cursor sync-models --variants --compact`.
  # Refresh with: npx @rama_nigg/open-cursor@latest sync-models --variants --compact
  # then copy provider.cursor-acp.models into this file (drop any cursor-acp/auto key).
  cursorAcpModels = builtins.fromJSON (builtins.readFile ./cursor-acp-models.json);
in
{
  programs.opencode.settings = {
    # https://github.com/Nomadcxx/opencode-cursor — bridges Cursor Pro
    # models into opencode. Requires the `cursor-agent` command
    # (see modules/terminal/cursor-agent.nix) and `cursor-agent login`.
    plugin = lib.mkAfter [ "@rama_nigg/open-cursor@latest" ];

    provider.cursor-acp = {
      name = "Cursor ACP";
      npm = "@ai-sdk/openai-compatible";
      options = {
        baseURL = "http://127.0.0.1:32124/v1";
      };
      models = cursorAcpModels;
    };
  };
}
