# FZF-related shell functions

# Ripgrep with fzf integration - opens results in vim
frg() {
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
    --bind "start:$RELOAD" --bind "change:$RELOAD" \
    --bind "enter:become:$OPENER" \
    --bind "ctrl-o:execute:$OPENER" \
    --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
    --delimiter : \
    --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
    --preview-window '~4,+{2}+4/3,<80(up)' \
    --query "$*"
}

# Switch the current kubectl context
ks() {
  if [ -n "$1" ]; then
    CONTEXT="$1"
  else
    CONTEXT="$(ls ~/.kube/configs/ | fzf --height 30%)"
  fi
  export KUBECONFIG=~/.kube/configs/"$CONTEXT"
}

