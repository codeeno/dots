{ config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      extended = true;
      ignoreAllDups = true;
      share = false;
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

      # Replacements
      vim = "nvim";
      diff = "delta --side-by-side";

      # Eza
      ll = "eza --long --header --git --all";
      tree = "eza --tree --long --git --header --git-ignore";

      # Git related
      ci = "NO_PROMPT=1 glab ci status | grep '^https' | xargs open";
      groot = "cd $(git rev-parse --show-toplevel)";

      # Misc
      weather = "curl wttr.in";
      hm = "home-manager switch --flake ~/projects/dots";
      assume = ". assume";
      sso = ". assume";
    };

    initContent = ''
      # Source local overrides if present
      [[ -f "$ZDOTDIR/.zshrc_local" ]] && source "$ZDOTDIR/.zshrc_local"

      # AWS CLI autocomplete
      autoload bashcompinit && bashcompinit
      complete -C 'aws_completer' aws

      # Load kubeconfigs from ~/.kube/configs
      [[ -d ~/.kube/configs ]] && export KUBECONFIG=$(echo ~/.kube/config ~/.kube/configs/*(.) | tr ' ' ':')

      # Get a parameter from AWS SSM
      param() {
        aws ssm get-parameter --name $(aws ssm describe-parameters --output text --query 'Parameters[].[Name]' | fzf) --output text --with-decryption --query 'Parameter.Value'
      }

      # Get a secret from AWS Secrets Manager
      secret() {
        aws secretsmanager get-secret-value --secret-id $(aws secretsmanager list-secrets --output text --query 'SecretList[].[Name]' | fzf) --query 'SecretString'
      }

      # Tail logs from a give CloudWatch log group
      logs() {
        aws logs tail $(aws logs describe-log-groups --output text --query 'logGroups[*].[logGroupName]' | fzf) --follow --since 30m
      }

      # Kill a process running on a given port
      killport() {
        lsof -i tcp:$@ | xargs kill
      }

      # Open the current git repo in the browser
      gopen ()
      {
          ( set -e;
          git remote -v | grep push;
          remote=''${"1:-origin"};
          echo "Using remote $remote";
          URL=$(git config remote.$remote.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/");
          echo "Opening $URL...";
          if command -v xdg-open >/dev/null 2>&1; then
              LIBVA_DRIVER_NAME=radeonsi xdg-open $URL
          else
              open $URL
          fi
        )
      }

      # Git branch using fzf
      fgb() {
          git rev-parse HEAD > /dev/null 2>&1 || return

          git branch --color=always --all --sort=-committerdate |
              grep -v HEAD |
              fzf --height 50% --ansi --no-multi --preview-window right:65% \
                  --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
              sed "s/.* //"
      }

      # Wrapper for the previous function to checkout the selected branch
      fgc() {
          git rev-parse HEAD > /dev/null 2>&1 || return

          local branch

          branch=$(fgb)
          if [[ "$branch" = "" ]]; then
              echo "No branch selected."
              return
          fi

          # If branch name starts with 'remotes/' then it is a remote branch. By
          # using --track and a remote branch name, it is the same as:
          # git checkout -b branchName --track origin/branchName
          if [[ "$branch" = 'remotes/'* ]]; then
              git checkout --track $branch
          else
              git checkout $branch;
          fi
      }
    '';
  };
}

############################
## Oh My Zsh
############################

#plugins=(
#  git
#  docker
#  kubectl
#)

## Disable colors for tab autocomplete
#zstyle ':completion:*' list-colors

## Source Oh My Zsh
#source $ZDOTDIR/ohmyzsh/oh-my-zsh.sh

############################
## Initialisations
############################

##### Github Copilot CLI
## eval "$(gh copilot alias -- zsh)"
