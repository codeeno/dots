{ lib, ... }:
{
  programs.zellij = {
    enable = lib.mkDefault true;
  };

  xdg.configFile."zellij/config.kdl".text = ''
    theme "tokyo-night-storm"

    keybinds {
      normal {
        bind "Alt n" { NewTab; SwitchToMode "Normal"; }
        bind "Alt w" { CloseTab; SwitchToMode "Normal"; }
      }
    }
  '';
}
