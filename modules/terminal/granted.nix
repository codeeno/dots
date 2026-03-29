{ lib, ... }:
{
  programs.granted = {
    enable = lib.mkDefault true;
    enableZshIntegration = true;
  };

  # ~/.granted/config — the HM module doesn't manage this file
  # Only set values that differ from defaults; granted handles the rest
  home.shellAliases.sso = "assume";

  home.file.".granted/config".text = lib.mkDefault ''
    DefaultBrowser = "FIREFOX"
    CredentialProcessAutoLogin = true
  '';
}
