{ ... }:
{
  system.primaryUser = "d434547";

  # Enable touch ID for sudo
  security.pam.services.sudo_local.reattach = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "uninstall"; # Uninstall packages not listed below
    };

    taps = [ ];

    brews = [
      "duckdb"
      "chdig"
    ];

    casks = [
      "notunes"
      "drawio"
      "claude"
      "zed"
    ];
  };

  system = {
    stateVersion = 6; # Required for nix-darwin

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
      };
    };
  };
}
