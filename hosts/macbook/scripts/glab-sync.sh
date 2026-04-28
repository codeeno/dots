#!/usr/bin/env bash
set -euo pipefail

: "${GITLAB_HOST:?set GITLAB_HOST before running}"

ROOT="$PWD"

if [ ! -d "$ROOT" ]; then
  echo "no directory at $ROOT — create it and add a subdir per group" >&2
  exit 1
fi

sync_group() {
  local group="$1"
  local root="$ROOT/$group"

  echo "═══ $group ═══"

  glab repo list --group "$group" --include-subgroups --all --output json |
    jq -r '.[] | "\(.ssh_url_to_repo)\t\(.path_with_namespace)"' |
    while IFS=$'\t' read -r url full_path; do
      rel="${full_path#"$group"/}"
      dir="$root/$rel"

      if [ -d "$dir/.git" ]; then
        echo "↻ updating $dir"
        git -C "$dir" fetch --all --prune --quiet
        git -C "$dir" pull --ff-only --quiet || echo "  ⚠ skipped (non-ff or dirty)"
      else
        echo "+ cloning $url → $dir"
        mkdir -p "$(dirname "$dir")"
        git clone --quiet "$url" "$dir"
      fi
    done
}

# Each immediate subdir of $ROOT is a group name
for dir in "$ROOT"/*/; do
  [ -d "$dir" ] || continue # handles the empty-glob case
  group=$(basename "$dir")
  sync_group "$group"
done
