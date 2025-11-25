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

    sessionVariables = {
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
      PGHOST = "localhost"; # I dont really know why I need to set this for postgres to work in docker...
      EZA_CONFIG_DIR = "${config.xdg.configHome}/eza";
    };

    shellAliases = {
      # Shorthands
      k = "kubecolor";
      kc = "kubectx";
      ldo = "lazydocker";
      tf = "tofu";
      tg = "terragrunt";
      yz = "yazi";
      ".." = "cd ..";

      # Replacements
      vim = "nvim";
      diff = "delta --side-by-side";

      # Eza
      ll = "eza --long --header --git --all";
      tree = "eza --tree --icons";

      # Git related
      ci = "NO_PROMPT=1 glab ci status | grep '^https' | xargs open";
      groot = "cd $(git rev-parse --show-toplevel)";

      # Misc
      weather = "curl wttr.in";
      sz = "source $ZDOTDIR/.zshrc && echo 'Sourced!'";
      assume = ". assume";
      sso = ". assume";
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

      # Source local overrides if present
      [[ -f "$ZDOTDIR/.zshrc_local" ]] && source "$ZDOTDIR/.zshrc_local"

      # AWS CLI autocomplete
      autoload bashcompinit && bashcompinit
      complete -C 'aws_completer' aws

      # Source custom functions
      source ${./functions/git.zsh}
      source ${./functions/aws.zsh}
      source ${./functions/fzf.zsh}
    '';
  };

  programs.zoxide.enable = true;
}
