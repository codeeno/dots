{ config, lib, ... }:
let
  cfg = config.modules.programs.editors.zed;
in
{
  options.modules.programs.editors.zed = {
    enable = lib.mkEnableOption "zed editor";
  };

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      userSettings = {
        theme = "Tokyo Night Moon";
      };
      extensions = [
        "nix"
        "tokyo-night"
      ];
    };
  };
}
