{ user, ... }:
{
  system.primaryUser = user;

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
      "openssl"
    ];

    casks = [
      "notunes"
      "drawio"
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
