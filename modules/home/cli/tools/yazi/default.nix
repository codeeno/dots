{ config, lib, ... }:
let
  cfg = config.modules.cli.tools.yazi;
in
{
  options.modules.cli.tools.yazi = {
    enable = lib.mkEnableOption "yazi file manager";
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
    };
  };
}
