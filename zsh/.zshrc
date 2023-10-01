###########################
# Includes
###########################

if [[ -f "$HOME/.zshrc_local" ]]; then
    source "$HOME/.zshrc_local"
fi

###########################
# Paths
###########################

##### Rust
export PATH="$HOME/.cargo/bin:$PATH"

##### Home binaries
export PATH="$HOME/bin:$PATH"

##### Scripts folder
export PATH=$PATH:"$HOME/scripts"

###########################
# Env Vars
##########################

##### NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

##### Locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#### I dont really know why I need to set this for postgres to work in docker...
export PGHOST=localhost 

#### AWS
export AWS_PAGER=""

###########################
# Initialisations
##########################

# Enable FZF Keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#### Init AWS Cli autocompletion
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

#### Disable colors for tab autocomplete
zstyle ':completion:*' list-colors

###########################
# Prompt engine
###########################

eval "$(starship init zsh)"

###########################
# Oh My Zsh
##########################

plugins=(
  git
  docker
  zsh-autosuggestions
  zsh-syntax-highlighting
  kubectl
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

###########################
# Aliases
###########################

unalias ll

# Shortcuts
alias lg="lazygit"
alias ldocker="lazydocker"
alias tg="terragrunt"
alias tf="terraform"

# Replacements
alias vim='nvim'
alias ssh="kitty +kitten ssh" # Continue SSH session when opnening a new tab/split
alias diff='delta --side-by-side'

# Eza
alias ll="eza --long --header --git --all"
alias tree="eza --tree --long --git --header --git-ignore"

# Git related
alias ci="NO_PROMPT=1 glab ci status | grep '^https' | xargs open"
alias groot='cd $(git rev-parse --show-toplevel)'

# Podman aliases
alias docker='nerdctl'
alias docker-compose='podman-compose'

# Misc
alias weather="curl wttr.in"

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
  aws logs tail $(aws logs describe-log-groups --output text --query 'logGroups[*].[logGroupName]' | fzf) --follow --since 3h
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
    LIBVA_DRIVER_NAME=radeonsi xdg-open $URL )
}

