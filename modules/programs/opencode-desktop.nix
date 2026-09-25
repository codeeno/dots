{
  lib,
  pkgs,
  ...
}:
{
  # Desktop client for opencode. It reads the same ~/.config/opencode/opencode.json
  # that modules/terminal/opencode writes, so providers, MCP servers, skills and
  # plugins are shared with the CLI. Taken from the same nixpkgs rev as
  # programs.opencode.package so both sides stay on one version of the shared
  # session database in ~/.local/share/opencode.
  home.packages = with pkgs; [
    opencode-desktop
  ];

  # Apps started from Dock/Finder/Raycast inherit the launchd session environment,
  # not the shell, so home.sessionVariables never reaches them. The websearch tool
  # is gated on OPENCODE_ENABLE_EXA being in process.env at startup and has no
  # equivalent key in opencode.json (checked against the config schema shipped with
  # 1.18.28), so export it into the launchd session instead.
  launchd.agents.opencode-env = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    enable = true;
    config = {
      ProgramArguments = [
        "/bin/launchctl"
        "setenv"
        "OPENCODE_ENABLE_EXA"
        "1"
      ];
      RunAtLoad = true;
    };
  };
}
