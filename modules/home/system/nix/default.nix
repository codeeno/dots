{ config, lib, ... }:
let
  cfg = config.modules.system.nix;
in
{
  options.modules.system.nix = {
    enable = lib.mkEnableOption "Nix-specific workarounds";
  };

  config = lib.mkIf cfg.enable {
    # Disable manual generation to avoid builtins.toFile warning
    # See: https://github.com/nix-community/home-manager/issues/7935
    # TODO: Remove this once issue is resolved
    manual.manpages.enable = false;
  };
}
