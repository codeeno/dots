{ pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = lib.mkDefault true;
    package = pkgs.ghostty-bin;

    settings = {
      copy-on-select = "clipboard";
      font-family = "CaskaydiaCove Nerd Font Mono";
      theme = "TokyoNight Moon";
    };
  };
}
