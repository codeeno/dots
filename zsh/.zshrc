###########################
# Paths
###########################

#### Export local bin directory
export PATH=~/bin:$PATH

##### Python3
export PATH="$HOME/Library/Python/3.8/bin:$PATH"

##### Rust
export PATH="$HOME/.cargo/bin:$PATH"

##### Home Path
export PATH="$HOME/bin:$PATH"

##### Scripts folder
export PATH=$PATH:~/scripts

#### openjdk
export PATH="/usr/local/opt/openjdk/bin:$PATH"

##### ZSH Stuff
#ZSH_THEME="powerlevel10k/powerlevel10k"

##### Oh My Zsh
export ZSH="/home/eeno/.oh-my-zsh"

#### Go
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)

###########################
#Initialisations 
###########################

#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#i
#
## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(starship init zsh)"

###########################
# Oh My Zsh
##########################

plugins=(
  git
  docker
  zsh-autosuggestions
  kubectl
)

source $ZSH/oh-my-zsh.sh

###########################
# Aliases
###########################

unalias ll
unalias gl
alias medis="sh -c 'cd /Users/d434547/Misc/medis && npm start'"
alias ll="exa --long --header --git --all"
alias tree="exa --tree --long --git --header --git-ignore"
alias tf="terraform"
alias tg="terragrunt"
alias groot='cd $(git rev-parse --show-toplevel)'
alias kc="kubectl"
alias weather="curl wttr.in"
alias fcd='cd $(fd --type d --hidden --follow --exclude .git ${1:-.} | fzf)'
alias diff='delta --side-by-side'
alias docker='nerdctl'
alias vim='nvim'

###########################
# Scripts/Functions
###########################

logs() {
  aws logs tail $(aws logs describe-log-groups --output text --query 'logGroups[*].[logGroupName]' | fzf) --follow --since 3h
}

# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
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

fgc() {
  git rev-parse HEAD > /dev/null 2>&1 || return

  git branch --color=always --all --sort=-committerdate |
    grep -v HEAD |
    fzf --height 50% --ansi --no-multi --preview-window right:65% \
        --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
    sed "s/.* //"
}

ichbinimoffice() {
  node /Users/d434547/Misc/wer-ist-im-office-sign-in/sign-in.js
}
###########################
# Env Vars
##########################

##### NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

##### Locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#### I dont really know why I need to set this for postgres to work in docker...
export PGHOST=localhost 

#### AWS
export AWS_PAGER=""

#### Ripgrep
export RIPGREP_CONFIG_PATH=/Users/d434547/.config/ripgrep/config

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

