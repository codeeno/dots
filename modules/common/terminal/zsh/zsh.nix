{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 50000;
      save = 50000;
      path = "${config.xdg.dataHome}/zsh/history";
      extended = true;
      ignoreDups = true;
      ignoreAllDups = false;
      share = false;
      append = true;
    };

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }

    ];

    initContent = ''
      # Required for so that the fzf CTRL+R keybind still works despite zvm-vi-mode having overridden it
      # See: https://github.com/jeffreytse/zsh-vi-mode/issues/242
      function zvm_after_init() {
        zvm_bindkey viins '^R' fzf-history-widget
        zvm_bindkey vicmd '^R' fzf-history-widget
      }

      # AWS CLI autocomplete
      autoload bashcompinit && bashcompinit
      complete -C 'aws_completer' aws

      # Source custom functions
      source ${./functions/git.zsh}
      source ${./functions/aws.zsh}
      source ${./functions/fzf.zsh}
    '';

    shellAliases = {
      zs = "source $ZDOTDIR/.zshrc && echo 'Sourced!'";
    };
  };

  programs.zoxide.enable = true;
}
