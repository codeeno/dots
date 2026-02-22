{ lib, ... }:
{
  programs.zellij = {
    enable = lib.mkDefault true;
  };

  xdg.configFile."zellij/config.kdl".text = ''

    //####################################################
    //# General
    //####################################################

    theme "tokyo-night-storm"
    copy_on_select true
    default_shell "zsh"

    //####################################################
    //# Keybinds
    //####################################################

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

        // Navigate panes (arrow keys only, Ctrl hjkl handled by vim-zellij-navigator)
        bind "Left" { MoveFocus "Left"; }
        bind "Right" { MoveFocus "Right"; }
        bind "Down" { MoveFocus "Down"; }
        bind "Up" { MoveFocus "Up"; }

        // Navigate tabs
        bind "Alt Shift h" { GoToPreviousTab; }
        bind "Alt Shift l" { GoToNextTab; }

        // Resize
        bind "Alt Left" { Resize "Increase Left"; }
        bind "Alt Down" { Resize "Increase Down"; }
        bind "Alt Up" { Resize "Increase Up"; }
        bind "Alt Right" { Resize "Increase Right"; }
      }

      // New keybind for move mode since we've replaced the default "Ctrl h" keybind
      shared_except "move" "locked" {
          bind "Ctrl m" { SwitchToMode "Move"; }
      }

      // vim-zellij-navigator: forwards Ctrl hjkl to vim when focused, otherwise moves zellij panes
      shared_except "locked" {
        bind "Ctrl h" {
          MessagePlugin "https://github.com/hiasr/vim-zellij-navigator/releases/download/0.3.0/vim-zellij-navigator.wasm" {
            name "move_focus";
            payload "left";
            move_mod "ctrl";
          };
        }
        bind "Ctrl j" {
          MessagePlugin "https://github.com/hiasr/vim-zellij-navigator/releases/download/0.3.0/vim-zellij-navigator.wasm" {
            name "move_focus";
            payload "down";
            move_mod "ctrl";
          };
        }
        bind "Ctrl k" {
          MessagePlugin "https://github.com/hiasr/vim-zellij-navigator/releases/download/0.3.0/vim-zellij-navigator.wasm" {
            name "move_focus";
            payload "up";
            move_mod "ctrl";
          };
        }
        bind "Ctrl l" {
          MessagePlugin "https://github.com/hiasr/vim-zellij-navigator/releases/download/0.3.0/vim-zellij-navigator.wasm" {
            name "move_focus";
            payload "right";
            move_mod "ctrl";
          };
        }
      }
    }
  '';
}
