{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.custom) granted;
  inherit (pkgs.stdenv) isDarwin;
  boolToString = b: if b then "true" else "false";
in
{
  options.custom.granted = {
    defaultBrowser = lib.mkOption {
      type = lib.types.str;
      default = "FIREFOX";
      description = "Browser name for granted (e.g. FIREFOX, CHROME, CHROMIUM, EDGE, BRAVE).";
    };

    browserPath = lib.mkOption {
      type = lib.types.str;
      default =
        if isDarwin then
          "/Applications/Firefox Developer Edition.app/Contents/MacOS/firefox"
        else
          "firefox";
      description = "Path to the browser binary used for SSO and general granted browser access.";
    };

    keyringBackend = lib.mkOption {
      type = lib.types.str;
      default = if isDarwin then "keychain" else "secret-service";
      description = "Keyring backend for credential storage.";
    };

    credentialProcessAutoLogin = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to automatically login during credential process.";
    };
  };

  config = {
    programs.granted = {
      enable = lib.mkDefault true;
      enableZshIntegration = true;
    };

    home = {
      shellAliases.sso = "assume";

      # granted rewrites this file at runtime, so we copy instead of symlink
      # to keep it writable
      activation.grantedConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "$HOME/.granted"
        rm -f "$HOME/.granted/config"
        cat > "$HOME/.granted/config" <<'EOF'
        DefaultBrowser = "${granted.defaultBrowser}"
        CustomBrowserPath = "${granted.browserPath}"
        CustomSSOBrowserPath = "${granted.browserPath}"
        CredentialProcessAutoLogin = ${boolToString granted.credentialProcessAutoLogin}

        [Keyring]
          Backend = "${granted.keyringBackend}"
        EOF
      '';
    };
  };
}
