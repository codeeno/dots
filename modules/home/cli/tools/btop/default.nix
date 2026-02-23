{ config, lib, pkgs, ... }:
let
  cfg = config.modules.cli.tools.btop;
in
{
  options.modules.cli.tools.btop = {
    enable = lib.mkEnableOption "btop system monitor";
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "${pkgs.btop}/share/btop/themes/tokyo-night.theme";
        vim_keys = true;
      };
    };
  };
}
