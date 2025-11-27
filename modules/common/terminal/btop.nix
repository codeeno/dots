{
  pkgs,
  ...
}:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "${pkgs.btop}/share/btop/themes/tokyo-night.theme";
      vim_keys = true;
    };
  };
}
