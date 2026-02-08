#!/bin/bash
# Usage: bash /path/to/dotfiles/agents/install.sh
# Runs rulesync generate in agents/ then creates symlinks for ~/.cursor/ (and optionally ~/.claude/)

set -e

AGENTS_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_CURSOR="$HOME/.cursor"
TARGET_CLAUDE="$HOME/.claude"

echo "Running rulesync generate in $AGENTS_DIR..."
(cd "$AGENTS_DIR" && rulesync generate) || {
  echo "Error: rulesync generate failed. Install rulesync: npm install -g rulesync or brew install rulesync"
  exit 1
}

echo "Creating global Cursor symlinks..."
mkdir -p "$TARGET_CURSOR"
if [ -d "$AGENTS_DIR/.cursor" ]; then
  for dir in "$AGENTS_DIR/.cursor"/*; do
    [ -d "$dir" ] || continue
    name="$(basename "$dir")"
    if [ -e "$TARGET_CURSOR/$name" ] && [ ! -L "$TARGET_CURSOR/$name" ]; then
      echo "Warning: $TARGET_CURSOR/$name exists and is not a symlink. Skipping."
    else
      ln -sfn "$AGENTS_DIR/.cursor/$name" "$TARGET_CURSOR/$name"
      echo "Linked: $TARGET_CURSOR/$name -> $AGENTS_DIR/.cursor/$name"
    fi
  done
fi

echo "Creating global Claude symlinks..."
mkdir -p "$TARGET_CLAUDE"
if [ -d "$AGENTS_DIR/.claude" ]; then
  for item in "$AGENTS_DIR/.claude"/*; do
    [ -e "$item" ] || continue
    name="$(basename "$item")"
    if [ -e "$TARGET_CLAUDE/$name" ] && [ ! -L "$TARGET_CLAUDE/$name" ]; then
      echo "Warning: $TARGET_CLAUDE/$name exists and is not a symlink. Skipping."
    else
      ln -sfn "$item" "$TARGET_CLAUDE/$name"
      echo "Linked: $TARGET_CLAUDE/$name -> $item"
    fi
  done
fi

echo "Done!"
