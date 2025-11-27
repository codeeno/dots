{ lib, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "CaskaydiaCove Nerd Font Mono";
      copy-on-select = "clipboard";
    };
  };
}
