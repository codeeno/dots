#!/usr/bin/env bash
set -euo pipefail

ROOT="$PWD"
PAGE_SIZE=100
TARGETS=()

usage() {
  cat <<'EOF'
glab-sync — clone/update every GitLab repo in a namespace into $PWD

usage:
  glab-sync                       sync one namespace per subdirectory of $PWD
  glab-sync -g NAME [-g NAME]...  sync only the named namespace(s)
  glab-sync NAME [NAME]...        same, as positional arguments

A namespace is either a group (synced with its subgroups) or a personal user
namespace. Named targets do not need an existing subdirectory; it is created.

flags:
  -g, --group NAME  namespace to sync; repeat for several
  -h, --help        show this help

env:
  GITLAB_HOST       required, e.g. gitlab.example.com
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    -g | --group)
      if [ $# -lt 2 ] || [ -z "$2" ]; then
        echo "$1 requires a namespace argument" >&2
        exit 2
      fi
      TARGETS+=("$2")
      shift 2
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    --)
      shift
      while [ $# -gt 0 ]; do
        TARGETS+=("$1")
        shift
      done
      ;;
    -*)
      echo "unknown flag: $1" >&2
      usage >&2
      exit 2
      ;;
    *)
      TARGETS+=("$1")
      shift
      ;;
  esac
done

: "${GITLAB_HOST:?set GITLAB_HOST before running}"

if [ ! -d "$ROOT" ]; then
  echo "no directory at $ROOT — create it and add a subdir per group" >&2
  exit 1
fi

# glab reports API errors as a JSON object on stdout, so every response has to
# be validated as an array before it is fed to the repo-extracting jq filter.
fetch_page() {
  local kind="$1" name="$2" page="$3"

  if [ "$kind" = "group" ]; then
    glab repo list --group "$name" --include-subgroups --all \
      --per-page "$PAGE_SIZE" --page "$page" --output json 2>/dev/null
  else
    glab repo list --user "$name" \
      --per-page "$PAGE_SIZE" --page "$page" --output json 2>/dev/null
  fi
}

# A namespace may be a group or a personal user namespace; they need different
# flags, so probe the group endpoint first and fall back to the user endpoint.
detect_kind() {
  local name="$1" kind
  for kind in group user; do
    if fetch_page "$kind" "$name" 1 | jq -e 'type == "array"' >/dev/null 2>&1; then
      printf '%s' "$kind"
      return 0
    fi
  done
  return 1
}

list_repos() {
  local kind="$1" name="$2" page=1 batch count

  while :; do
    batch=$(fetch_page "$kind" "$name" "$page")
    count=$(printf '%s' "$batch" | jq 'length')

    printf '%s' "$batch" |
      jq -r '.[] | select(.ssh_url_to_repo != null)
             | "\(.ssh_url_to_repo)\t\(.path_with_namespace)"'

    if [ "$count" -lt "$PAGE_SIZE" ]; then
      break
    fi
    page=$((page + 1))
  done
}

sync_namespace() {
  local name="$1"
  local root="$ROOT/$name"
  local kind repos url full_path rel dir

  echo "═══ $name ═══"

  if ! kind=$(detect_kind "$name"); then
    echo "  ⚠ no group or user namespace matching '$name' — skipped" >&2
    return 0
  fi

  repos=$(list_repos "$kind" "$name")

  if [ -z "$repos" ]; then
    echo "  (no repositories)"
    return 0
  fi

  while IFS=$'\t' read -r url full_path; do
    [ -n "$url" ] || continue
    rel="${full_path#"$name"/}"
    dir="$root/$rel"

    if [ -d "$dir/.git" ]; then
      echo "↻ updating $dir"
      git -C "$dir" fetch --all --prune --quiet || echo "  ⚠ fetch failed"
      git -C "$dir" pull --ff-only --quiet || echo "  ⚠ skipped (non-ff or dirty)"
    else
      echo "+ cloning $url → $dir"
      mkdir -p "$(dirname "$dir")"
      git clone --quiet "$url" "$dir" || echo "  ⚠ clone failed"
    fi
  done <<<"$repos"
}

if [ ${#TARGETS[@]} -gt 0 ]; then
  for name in "${TARGETS[@]}"; do
    sync_namespace "$name"
  done
else
  # Each immediate subdir of $ROOT is a group or user namespace
  for dir in "$ROOT"/*/; do
    [ -d "$dir" ] || continue # handles the empty-glob case
    sync_namespace "$(basename "$dir")"
  done
fi
