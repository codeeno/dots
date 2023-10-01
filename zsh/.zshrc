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

export ZSH="/home/eeno/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

###########################
# Aliases
###########################

unalias ll
unalias gl
alias ll="eza --long --header --git --all"
alias tree="eza --tree --long --git --header --git-ignore"
alias tf="terraform"
alias tg="terragrunt"
alias groot='cd $(git rev-parse --show-toplevel)'
alias weather="curl wttr.in"
alias diff='delta --side-by-side'
alias docker='nerdctl'
alias vim='nvim'

###########################
# Scripts/Functions
###########################

logs() {
  aws logs tail $(aws logs describe-log-groups --output text --query 'logGroups[*].[logGroupName]' | fzf) --follow --since 3h
}

sso() {
   command aws-sso-cli "$@" | while read -r line; do
    if [[ $line =~ ^export ]]; then
      eval $line
    fi
  done
}

gl() {
  git log --oneline | fzf --preview 'git show --color=always $(echo {} | cut -d" " -f1) | delta'
}

param() {
  aws ssm get-parameter --name $(aws ssm describe-parameters --output text --query 'Parameters[].[Name]' | fzf) --output text --with-decryption --query 'Parameter.Value'
}

secret() {
  aws secretsmanager get-secret-value --secret-id $(aws secretsmanager list-secrets --output text --query 'SecretList[].[Name]' | fzf) --query 'SecretString'
}

killport() {
  lsof -i tcp:$@ | xargs kill
}
