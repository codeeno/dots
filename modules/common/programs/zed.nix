{ lib, ... }:

{
  programs.zed-editor = {
    enable = lib.mkDefault true;

  };
}
