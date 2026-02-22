{ lib, ... }:
{
  programs.zellij = {
    enable = lib.mkDefault true;
  };

  xdg.configFile."zellij/config.kdl".text = ''
    theme "tokyo-night-storm"

    keybinds {
      // Set up some additional keybinds for normal mode to replicate previous tmux setup
      normal {

        // Create and close panes and tabs
        bind "Alt t" { NewTab; }
        bind "Alt d" { NewPane "Right"; }
        bind "Alt w" { CloseFocus; }
        bind "Alt Shift d" { NewPane "Down"; }

        // Move tabs
        bind "Ctrl Alt Shift h" { MoveTab "Left"; }
        bind "Ctrl Alt Shift l" { MoveTab "Right"; }

        // Navigate panes
        bind "Ctrl h" "Left" { MoveFocus "Left"; }
        bind "Ctrl l" "Right" { MoveFocus "Right"; }
        bind "Ctrl j" "Down" { MoveFocus "Down"; }
        bind "Ctrl k" "Up" { MoveFocus "Up"; }

        // Navigate tabs
        bind "Alt Shift h" { GoToPreviousTab; }
        bind "Alt Shift l" { GoToNextTab; }

        // Resize
        bind "Alt Left" { Resize "Increase Left"; }
        bind "Alt Down" { Resize "Increase Down"; }
        bind "Alt Up" { Resize "Increase Up"; }
        bind "Alt Right" { Resize "Increase Right"; }
        bind "Alt Shift Left" { Resize "Decrease Left"; }
        bind "Alt Shift Down" { Resize "Decrease Down"; }
        bind "Alt Shift Up" { Resize "Decrease Up"; }
        bind "Alt Shift Right" { Resize "Decrease Right"; }
      }

      // New keybind for move mode since we've replaced the default "Ctrl h" keybind
      shared_except "move" "locked" {
          bind "Ctrl m" { SwitchToMode "Move"; }
      }
    }

    copy_on_select true
    default_shell "zsh"
  '';
}
