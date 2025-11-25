{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    shell = "${pkgs.zsh}/bin/zsh";
    shortcut = "b";
    mouse = true;
    escapeTime = 0;
    clock24 = true;
    baseIndex = 1;
    focusEvents = true;

    extraConfig = ''
      ######################################
      # Basics
      ######################################

      # Override default-command set by sensible plugin (which uses reattach-to-user-namespace with $SHELL)
      # This ensures the Nix zsh is used instead of system shell
      set -g default-command "${pkgs.zsh}/bin/zsh"

      # Get Tmux to support both true color and italics
      set-option -g default-terminal "tmux-256color"
      set -as terminal-features ",xterm-256color:RGB"
      set -as terminal-overrides ",xterm-kitty:RGB:Tc"
      set -as terminal-overrides ",*:Tc"

      # Automatically set window title
      set-window-option -g automatic-rename on
      set-option -g set-titles on

      # Where the status bar is to be positioned
      set-option -g status-position bottom

      # Use vi keys in copy mode
      setw -g mode-keys vi

      ######################################
      # Keybinds
      ######################################

      # Splitting panes
      bind -n M-d split-window -h -c "#{pane_current_path}"
      bind -n M-D split-window -v -c "#{pane_current_path}"

      # Open window with currrent path
      bind -n M-t new-window -c "#{pane_current_path}"
      bind -n M-w kill-pane

      # Use Shift-Alt-vim keys without prefix to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Toggle fullscreen/zoom of current pane
      bind -n M-z resize-pane -Z

      # Select windows directly
      bind-key -n M-1 select-window -t 1
      bind-key -n M-2 select-window -t 2
      bind-key -n M-3 select-window -t 3
      bind-key -n M-4 select-window -t 4
      bind-key -n M-5 select-window -t 5
      bind-key -n M-6 select-window -t 6
      bind-key -n M-7 select-window -t 7
      bind-key -n M-8 select-window -t 8
      bind-key -n M-9 select-window -t 9

      # Easier resize
      bind-key -n M-Up    resize-pane -U 5
      bind-key -n M-Down  resize-pane -D 5
      bind-key -n M-Left  resize-pane -L 5
      bind-key -n M-Right resize-pane -R 5

      # Session management
      bind-key -n C-p choose-tree -s

      # Smart pane navigation - uses tmux's internal pane_current_command (no process spawning!)
      # This is much faster than the traditional ps|grep approach used by vim-tmux-navigator
      is_vim="#{m/ri:^(n?vim|nvim)$,#{pane_current_command}}"
      bind-key -n 'C-h' if-shell -F "$is_vim" "send-keys C-h" "select-pane -L"
      bind-key -n 'C-j' if-shell -F "$is_vim" "send-keys C-j" "select-pane -D"
      bind-key -n 'C-k' if-shell -F "$is_vim" "send-keys C-k" "select-pane -U"
      bind-key -n 'C-l' if-shell -F "$is_vim" "send-keys C-l" "select-pane -R"
      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R

      # Enter copy mode easier and make selection more like vim
      bind-key -n C-f copy-mode
      unbind-key -T copy-mode-vi v # Default rectangle selection key. Unbind to avoid conflict
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      # Swap current tab with next/previous
      bind-key -n C-M-S-l swap-window -t +1 \; next-window
      bind-key -n C-M-S-h swap-window -t -1 \; previous-window

      # Open a menu for opening some utilities in a popup
      bind -n M-o display-menu -T "#[align=centre fg=green]Launch Utility" -x C -y C \
          "btop"         b "display-popup -E -w 80% -h 80% 'btop'" \
          "lazygit"      g "display-popup -E -w 80% -h 80% 'lazygit'" \
          "lazydocker"   d "display-popup -E -w 80% -h 80% 'lazydocker'" \
          "k9s"          k "display-popup -E -w 80% -h 80% 'k9s'" \
          "home-manager" h "display-popup -E -w 80% -h 80% 'home-manager switch --flake ~/projects/dots#eeno@linux; read -n 1'"

      ######################################
      # Toggleable panes
      ######################################

      # Uses tmux format strings (-F) instead of spawning shells for reliability
      bind-key -n 'C-e' if-shell -F '#{==:#{window_panes},1}' {
        split-window -hf -l 90 -c '#{pane_current_path}'
      } {
        if-shell -F '#{window_zoomed_flag}' {
          select-pane -t:.-
        } {
          resize-pane -Z -t1
        }
      }
    '';

    plugins = with pkgs.tmuxPlugins; [
      { plugin = yank; }
      {
        plugin = tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_theme storm
          set -g @tokyo-night-tmux_transparent 1
          set -g @tokyo-night-tmux_window_id_style none
          set -g @tokyo-night-tmux_pane_id_style hide
          set -g @tokyo-night-tmux_zoom_id_style hide
          set -g @tokyo-night-tmux_show_path 1
          set -g @tokyo-night-tmux_path_format relative
          set -g @tokyo-night-tmux_show_battery_widget 0
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
      }
    ];
  };
}
