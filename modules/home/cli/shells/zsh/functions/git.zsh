# Git-related shell functions

# Open the current git repo in the browser
gopen() {
  (
    set -e
    git remote -v | grep push
    remote="${1:-origin}"
    echo "Using remote $remote"
    URL=$(git config remote.$remote.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")
    echo "Opening $URL..."
    if command -v xdg-open >/dev/null 2>&1; then
      LIBVA_DRIVER_NAME=radeonsi xdg-open $URL
    else
      open $URL
    fi
  )
}

# Git branch browser using fzf
fgb() {
  git rev-parse HEAD > /dev/null 2>&1 || return

  git branch --color=always --all --sort=-committerdate |
    grep -v HEAD |
    fzf --height 50% --ansi --no-multi --preview-window right:65% \
      --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
    sed "s/.* //"
}

# Checkout a git branch selected via fzf
fgc() {
  git rev-parse HEAD > /dev/null 2>&1 || return

  local branch
  branch=$(fgb)

  if [[ "$branch" = "" ]]; then
    echo "No branch selected."
    return
  fi

  # If branch name starts with 'remotes/' then it is a remote branch.
  # Using --track with a remote branch name is equivalent to:
  # git checkout -b branchName --track origin/branchName
  if [[ "$branch" = 'remotes/'* ]]; then
    git checkout --track $branch
  else
    git checkout $branch
  fi
}
