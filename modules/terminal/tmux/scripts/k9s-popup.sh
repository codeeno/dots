#!/usr/bin/env bash
# Toggle/create the persistent k9s tmux session shown in a popup.
#
# Behavior:
#   - If the current session is "k9s", detach (closes the popup, session keeps running).
#   - Otherwise, attach to "k9s". Create it if missing, with two windows pinned to
#     the production and sandbox EKS contexts.
#   - On every (re)attach, the active window is reset to "Tracking Production".
#
# KUBECONFIG is built from ~/.kube/config plus everything in ~/.kube/configs/*
# and passed via `tmux new -e` so it propagates into the new session's environment.

set -euo pipefail

SESSION="k9s"
PROD_CTX="arn:aws:eks:eu-central-1:400032194227:cluster/production-v3"
SBX_CTX="arn:aws:eks:eu-central-1:304863635032:cluster/sandbox-v3"
KKP_DEV_CTX="aws-kkp-ed2-datainfrastructure-development"
KKP_PROD_CTX="aws-kkp-ed2-datainfrastructure-production"
PROD_WIN="Tracking Production"
SBX_WIN="Tracking Sandbox"
KKP_DEV_WIN="Tracking KKP Dev"
KKP_PROD_WIN="Tracking KKP Prod"

# If we're already inside the k9s session, the toggle means "close the popup".
if [ "${TMUX:-}" ] && [ "$(tmux display-message -p '#S')" = "$SESSION" ]; then
  tmux detach-client
  exit 0
fi

# Create the session on first invocation.
created=0
if ! tmux has-session -t="$SESSION" 2>/dev/null; then
  created=1
  KUBECONFIG_MERGED="$(ls ~/.kube/config ~/.kube/configs/* 2>/dev/null | paste -sd: -)"

  # Window 1: production (must be the first window so it's the default on attach)
  tmux new-session -d -s "$SESSION" -n "$PROD_WIN" \
    -e "KUBECONFIG=$KUBECONFIG_MERGED" \
    "k9s --context '$PROD_CTX'"

  # Window 2: sandbox
  tmux new-window -t "$SESSION:" -n "$SBX_WIN" \
    -e "KUBECONFIG=$KUBECONFIG_MERGED" \
    "k9s --context '$SBX_CTX'"

  # Window 3: KKP production
  tmux new-window -t "$SESSION:" -n "$KKP_PROD_WIN" \
    -e "KUBECONFIG=$KUBECONFIG_MERGED" \
    "k9s --context '$KKP_PROD_CTX'"

  # Window 4: KKP development
  tmux new-window -t "$SESSION:" -n "$KKP_DEV_WIN" \
    -e "KUBECONFIG=$KUBECONFIG_MERGED" \
    "k9s --context '$KKP_DEV_CTX'"

  # Lock window names so k9s can't rename them.
  for win in 1 2 3 4; do
    tmux set-window-option -t "$SESSION:$win" automatic-rename off
    tmux set-window-option -t "$SESSION:$win" allow-rename off
  done
fi

# On first creation, land on the production window. Otherwise, keep whichever
# window was active when the user last detached.
if [ "$created" -eq 1 ]; then
  tmux select-window -t "$SESSION:1"
fi
tmux attach -t "$SESSION"
