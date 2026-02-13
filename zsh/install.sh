#!/bin/sh
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create backup directory
BACKUP_DIR="$SCRIPT_DIR/backup"
mkdir -p "$BACKUP_DIR"

# Backup existing .zshrc if it exists and is not already our symlink
if [ -e "$HOME/.zshrc" ]; then
  if [ -L "$HOME/.zshrc" ] && [ "$(readlink "$HOME/.zshrc")" = "$SCRIPT_DIR/zshrc" ]; then
    echo "Already linked: $HOME/.zshrc -> $(readlink "$HOME/.zshrc")"
    exit 0
  fi
  echo "Backing up existing .zshrc to $BACKUP_DIR"
  cp "$HOME/.zshrc" "$BACKUP_DIR/zshrc.$(date +%Y%m%d%H%M%S)"
fi

# Create symbolic link
ln -sf "$SCRIPT_DIR/zshrc" "$HOME/.zshrc"
echo "Linked $HOME/.zshrc -> $SCRIPT_DIR/zshrc"
echo ""
echo "To apply the changes, run:"
echo "  source ~/.zshrc"
