#!/bin/bash
# Usage: bash install-global.sh
# Creates symlinks for global Cursor configuration in ~/.cursor/

set -e

DOTFILES_CURSOR_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.cursor"

echo "Creating global Cursor symlinks..."

# Create symlinks for each directory
for dir in rules skills agents commands contexts hooks; do
  if [ -d "$DOTFILES_CURSOR_DIR/$dir" ]; then
    if [ -e "$TARGET_DIR/$dir" ] && [ ! -L "$TARGET_DIR/$dir" ]; then
      echo "Warning: $TARGET_DIR/$dir exists and is not a symlink. Skipping."
    else
      ln -sfn "$DOTFILES_CURSOR_DIR/$dir" "$TARGET_DIR/$dir"
      echo "Linked: $TARGET_DIR/$dir -> $DOTFILES_CURSOR_DIR/$dir"
    fi
  fi
done

echo "Done!"
