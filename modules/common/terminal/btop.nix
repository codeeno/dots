{
  pkgs,
  lib,
  ...
}:
{
  programs.btop = {
    enable = lib.mkDefault true;
    settings = {
      color_theme = "${pkgs.btop}/share/btop/themes/tokyo-night.theme";
      vim_keys = true;
    };
  };
}
