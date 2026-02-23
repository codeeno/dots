{ config, lib, pkgs, ... }:
let
  cfg = config.modules.programs.terminals.ghostty;
in
{
  options.modules.programs.terminals.ghostty = {
    enable = lib.mkEnableOption "ghostty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      package = pkgs.ghostty-bin;

      settings = {
        theme = "TokyoNight Moon";
        font-family = "CaskaydiaCove Nerd Font Mono";
        copy-on-select = "clipboard";
      };
    };
  };
}
