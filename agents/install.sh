#!/bin/bash
# 使い方: bash agents/install.sh [cursor|claude]
# rulesync generate のあと、agents/.cursor と .claude を ~/.cursor / ~/.claude にシンボリックリンクする。
# 引数で cursor または claude を指定するとその一方だけ行う。

set -e

AGENTS_DIR="$(cd "$(dirname "$0")" && pwd)"

link_agent_dir() {
  local name="$1"
  local src="$AGENTS_DIR/.$name"
  local target="$HOME/.$name"
  echo "Creating global $name symlinks..."
  mkdir -p "$target"
  for item in "$src"/*; do
    [ -e "$item" ] || continue
    local name_ent="$(basename "$item")"
    if [ -e "$target/$name_ent" ] && [ ! -L "$target/$name_ent" ]; then
      echo "Warning: $target/$name_ent exists and is not a symlink. Skipping."
    else
      ln -sfn "$item" "$target/$name_ent"
      echo "Linked: $target/$name_ent -> $item"
    fi
  done
  echo "$name install done."
}

echo "Running rulesync generate in $AGENTS_DIR..."
(cd "$AGENTS_DIR" && rulesync generate) || {
  echo "Error: rulesync generate failed. Install rulesync: npm install -g rulesync or brew install rulesync"
  exit 1
}

if [ -n "${1:-}" ]; then
  case "$1" in
    cursor|claude) link_agent_dir "$1" ;;
    *) echo "Usage: $0 [cursor|claude]" >&2; exit 1 ;;
  esac
else
  link_agent_dir cursor
  link_agent_dir claude
fi

echo "Done!"
