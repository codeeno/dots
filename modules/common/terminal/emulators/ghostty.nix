{ lib, ... }:

{
  programs.ghostty = {
    enable = lib.mkDefault true;
    settings = {
      font-family = "CaskaydiaCove Nerd Font Mono";
      copy-on-select = "clipboard";
    };
  };
}
