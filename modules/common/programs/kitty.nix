{ pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "tokyo_night_moon";

    settings = {
      ######################################
      # Fonts
      ######################################

      font_family = "family='CaskaydiaCove Nerd Font Mono' style=Regular features='+zero +ss02 +cv04 +cv16 +cv18 +cv19 +cv20'";
      bold_font = "family='CaskaydiaCove Nerd Font Mono' style=Bold features='+zero +ss02 +cv04 +cv16 +cv18 +cv19 +cv20'";
      italic_font = "family='CaskaydiaCove Nerd Font Mono' style='Light Italic' features='+zero +ss02 +cv04 +cv16 +cv18 +cv19 +cv20'";
      bold_italic_font = "family='CaskaydiaCove Nerd Font Mono' style='Bold Italic' features='+zero +ss02 +cv04 +cv16 +cv18 +cv19 +cv20'";
      font_features = "CaskaydiaCoveNFM-Italic calt +ss01";
      font_size = lib.mkDefault 12;

      ######################################
      # Configuration
      ######################################

      shell = "${pkgs.zsh}/bin/zsh --login";
      kitty_mod = lib.mkDefault "alt";

      symbol_map = "U+E000-U+F8FF,U+F0000-U+FFFFF,U+100000-U+10ffff CaskaydiaCove Nerd Font";
      copy_on_select = "yes";
      enable_audio_bell = "no";
      allow_remote_control = "yes";
      confirm_os_window_close = 1;

      enabled_layouts = "splits, stack";
      active_border_color = "#6272a4";
      draw_minimal_borders = "yes";

      tab_bar_style = "fade";
      tab_bar_edge = "top";
      tab_bar_align = "center";
      tab_title_template = "{index}";

      cursor_trail = 3;
      sync_to_monitor = "no";
    };

    ######################################
    # Keybindings
    ######################################
    keybindings = {

      "kitty_mod+c" = "copy_to_clipboard";
      "kitty_mod+v" = "paste_from_clipboard";

      # Unbind kitty default binding to free it up for use in other programs
      "kitty_mod+d" = "no_op";
      "kitty_mod+shift+d" = "no_op";
      "kitty_mod+w" = "no_op";

      "kitty_mod+up" = "no_op";
      "kitty_mod+left" = "no_op";
      "kitty_mod+right" = "no_op";
      "kitty_mod+down" = "no_op";

      "kitty_mod+k" = "no_op";
      "kitty_mod+h" = "no_op";
      "kitty_mod+l" = "no_op";
      "kitty_mod+j" = "no_op";

      "kitty_mod+t" = "no_op";
      "kitty_mod+shift" = "no_op";
      "kitty_mod+f" = "no_op";

      "kitty_mod+o" = "no_op";
      "kitty_mod+p" = "no_op";
      "kitty_mod+u" = "no_op";
    };
  };
}
