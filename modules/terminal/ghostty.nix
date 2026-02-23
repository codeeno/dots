{ pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = lib.mkDefault true;
    package = pkgs.ghostty-bin;

    settings = {
      theme = "TokyoNight Moon";
    };
  };
}
