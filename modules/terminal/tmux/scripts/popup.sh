#!/usr/bin/env bash
# Toggle the persistent "popup" tmux session, with one window per directory.
#
# Behavior:
#   - If we're already inside the popup session, detach (closes the popup).
#   - Otherwise attach to the popup session, creating it if missing.
#   - The window shown is the one belonging to $1 (the caller's current path).
#     If no window exists for that directory yet, a new one is created there.
#
# Windows are tagged with a @popup-dir user option, so the lookup keeps working
# even after the user cds around inside a window.

set -euo pipefail

SESSION="popup"
# The caller's directory arrives as the popup's working directory (display-popup
# -d, which tmux does format-expand). An explicit argument may still be passed;
# only trust it if it's an absolute path, since tmux does *not* expand formats in
# a popup's shell-command.
DIR="$PWD"
case "${1:-}" in
/*) DIR="$1" ;;
esac
# Normalize (strip trailing slash) so /foo and /foo/ map to the same window.
[ "$DIR" != "/" ] && DIR="${DIR%/}"
NAME="$(basename "$DIR")"

# Already inside the popup session: the toggle means "close the popup".
if [ "${TMUX:-}" ] && [ "$(tmux display-message -p '#S')" = "$SESSION" ]; then
  tmux detach-client
  exit 0
fi

new_window() {
  tmux new-window -t "$SESSION:" -n "$NAME" -c "$DIR"
  tmux set-window-option -t "$SESSION:" @popup-dir "$DIR"
  tmux set-window-option -t "$SESSION:" automatic-rename off
  tmux set-window-option -t "$SESSION:" allow-rename off
}

if ! tmux has-session -t="$SESSION" 2>/dev/null; then
  tmux new-session -d -s "$SESSION" -n "$NAME" -c "$DIR"
  tmux set-window-option -t "$SESSION:" @popup-dir "$DIR"
  tmux set-window-option -t "$SESSION:" automatic-rename off
  tmux set-window-option -t "$SESSION:" allow-rename off
else
  # Find an existing window tagged with this directory.
  target="$(tmux list-windows -t "$SESSION" -F '#{window_index}	#{@popup-dir}' |
    awk -F'\t' -v d="$DIR" '$2 == d { print $1; exit }')"

  if [ -n "$target" ]; then
    tmux select-window -t "$SESSION:$target"
  else
    new_window
  fi
fi

tmux attach -t "$SESSION"
