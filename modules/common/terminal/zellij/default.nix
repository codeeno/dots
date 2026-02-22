{ lib, ... }:
{
  programs.zellij = {
    enable = lib.mkDefault true;
  };

  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
        default_tab_template {
            children
            pane size=1 borderless=true {
                plugin location="https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm" {
                    format_left   "{mode} #[fg=#89B4FA,bold]{session}"
                    format_center "{tabs}"
                    format_right  "{command_git_branch} {datetime}"
                    format_space  ""

                    border_enabled  "false"
                    border_char     "─"
                    border_format   "#[fg=#6C7086]{char}"
                    border_position "top"

                    hide_frame_for_single_pane "true"

                    mode_normal  "#[bg=blue] "
                    mode_tmux    "#[bg=#ffc387] "

                    tab_normal   "#[fg=#6C7086] {name} "
                    tab_active   "#[fg=#9399B2,bold,italic] {name} "

                    command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                    command_git_branch_format      "#[fg=blue] {stdout} "
                    command_git_branch_interval    "10"
                    command_git_branch_rendermode  "static"

                    datetime        "#[fg=#6C7086,bold] {format} "
                    datetime_format "%A, %d %b %Y %H:%M"
                    datetime_timezone "Europe/Berlin"
                }
            }
        }
    }
  '';

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
