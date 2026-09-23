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
# even after the user cds around inside a window. Untagged windows (created with
# M-t, or predating the tagging) are adopted by matching the pane's current path
# instead of being duplicated.

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
# Resolve symlinks: tmux reports pane_current_path physically (/tmp -> /private/tmp
# on macOS), so the fallback match below only works if both sides agree.
DIR="$(cd "$DIR" 2>/dev/null && pwd -P || printf '%s' "$DIR")"
NAME="$(basename "$DIR")"

# Already inside the popup session: the toggle means "close the popup".
if [ "${TMUX:-}" ] && [ "$(tmux display-message -p '#S')" = "$SESSION" ]; then
  tmux detach-client
  exit 0
fi

# Pin a window by its window id. Targeting the id (not "$SESSION:", which means
# "whatever window is current") keeps the tag on the window we actually mean.
tag_window() {
  tmux set-window-option -t "$1" @popup-dir "$DIR"
  tmux set-window-option -t "$1" automatic-rename off
  tmux set-window-option -t "$1" allow-rename off
}

# Print the window id for $DIR: an exact @popup-dir tag wins, otherwise the
# first untagged window whose pane sits in $DIR. Prints nothing if neither match.
find_window() {
  # Not named "path": that is tied to $PATH in zsh, and this file may be sourced
  # or adapted by someone who does not notice the shebang.
  local id tag cwd fallback=""
  while IFS=$'\t' read -r id tag cwd; do
    if [ "$tag" = "$DIR" ]; then
      printf '%s\n' "$id"
      return 0
    fi
    if [ -z "$tag" ] && [ "$cwd" = "$DIR" ] && [ -z "$fallback" ]; then
      fallback="$id"
    fi
  done < <(tmux list-windows -t "$SESSION" \
    -F '#{window_id}'$'\t''#{@popup-dir}'$'\t''#{pane_current_path}')
  [ -n "$fallback" ] && printf '%s\n' "$fallback"
  return 0
}

if ! tmux has-session -t="$SESSION" 2>/dev/null; then
  win="$(tmux new-session -d -P -F '#{window_id}' -s "$SESSION" -n "$NAME" -c "$DIR")"
  tag_window "$win"
else
  win="$(find_window)"
  if [ -n "$win" ]; then
    # Adopted an untagged window: give it the canonical name too.
    if [ -z "$(tmux display-message -p -t "$win" '#{@popup-dir}')" ]; then
      tmux rename-window -t "$win" "$NAME"
    fi
    tag_window "$win"
    tmux select-window -t "$win"
  else
    win="$(tmux new-window -t "$SESSION:" -P -F '#{window_id}' -n "$NAME" -c "$DIR")"
    tag_window "$win"
  fi
fi

# Windows opened inside the popup session by other means (M-t) are untagged, so
# tmux would rename them after the foreground process. Re-set every run so
# already-running popup sessions pick it up too.
tmux set-hook -t "$SESSION" after-new-window 'set-window-option automatic-rename off'

tmux attach -t "$SESSION"
