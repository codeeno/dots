{ lib, ... }:

{
  programs.zed-editor = {
    enable = lib.mkDefault true;
    userSettings = {
      theme = "Tokyo Night Moon";
    };
    extensions = [
      "nix"
      "tokyo-night"
    ];
  };
}
