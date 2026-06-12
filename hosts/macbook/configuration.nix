{ user, ... }:
{
  system.primaryUser = user;

  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    user = user;
    autoMigrate = true;
  };

  # Enable touch ID for sudo
  security.pam.services.sudo_local.reattach = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  environment.etc."resolver/home".text = ''
    nameserver 10.0.1.50
  '';

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "uninstall"; # Uninstall packages not listed below
    };

    taps = [ ];

    brews = [
      "chdig"
      "duckdb"
      "openssl"
    ];

    casks = [
      "drawio"
      "notunes"
      "raycast"
      "headlamp"
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
