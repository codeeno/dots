###########################
# Includes
###########################

if [[ -f "$ZDOTDIR/.zshrc_local" ]]; then
    source "$ZDOTDIR/.zshrc_local"
fi

###########################
# Paths
###########################

##### Rust
export PATH="$HOME/.cargo/bin:$PATH"

##### Home binaries
export PATH="$HOME/bin:$PATH"

##### Scripts folder
export PATH="$HOME/scripts:$PATH"

##### Pipx
export PATH="$HOME/.local/bin:$PATH"

##### Go binaries
export PATH="$HOME/go/bin:$PATH"

##### Aws Completer
export PATH="/usr/local/bin:$PATH"

###########################
# Env Vars
##########################

#### Use neovim as default editor
export EDITOR=nvim

#### Set XDG_CONFI_HOME
export XDG_CONFIG_HOME="$HOME/.config"

#### Use vim as 'fc' editor
export FCEDIT=vim

##### Locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#### I dont really know why I need to set this for postgres to work in docker...
export PGHOST=localhost

#### AWS
export AWS_PAGER=""
export AWS_REGION="eu-central-1"

#### Disable annoying homebrew upgrade
export HOMEBREW_NO_AUTO_UPDATE=1

###########################
# History settings
##########################

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY_TIME

###########################
# Oh My Zsh
##########################

plugins=(
  git
  docker
  zsh-autosuggestions
  zsh-syntax-highlighting
  kubectl
  nvm
)

# Enable lazy loading on the built-in NVM plugin
zstyle ':omz:plugins:nvm' lazy yes

# Disable colors for tab autocomplete
zstyle ':completion:*' list-colors

# Source Oh My Zsh
source $ZDOTDIR/oh-my-zsh/oh-my-zsh.sh

###########################
# Aliases
###########################

# Shortcuts
alias lg="lazygit"
alias ldocker="lazydocker"
alias tg="terragrunt"
alias tf="terraform"

# Replacements
alias vim='nvim'
#alias ssh="kitty +kitten ssh" # Continue SSH session when opnening a new tab/split
alias diff='delta --side-by-side'

# Eza
unalias ll
alias ll="eza --long --header --git --all"
alias tree="eza --tree --long --git --header --git-ignore"

# Git related
alias ci="NO_PROMPT=1 glab ci status | grep '^https' | xargs open"
alias groot='cd $(git rev-parse --show-toplevel)'

# Misc
alias weather="curl wttr.in"

###########################
# Initialisations
##########################

# Starship prompt
eval "$(starship init zsh)"

# Enable FZF Keybindings
source <(fzf --zsh)

# Enable Zoxide
eval "$(zoxide init zsh)"

#### Github Copilot CLI
# eval "$(gh copilot alias -- zsh)"

###########################
# Command Completions
###########################

# Initialize completions
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# AWS CLI
complete -C '/opt/homebrew/bin/aws_completer' aws

###########################
# Scripts/Functions
###########################

# Get AWS credentials for a given profile using aws-sso-cli
sso() {
   command aws-sso-cli "$@" | while read -r line; do
    if [[ $line =~ ^export ]]; then
      eval $line
    fi
  done
}

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
    remote=${1:-origin};
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
