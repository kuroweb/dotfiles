#!/bin/sh
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MISE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/mise/config.toml"

# Create backup directory
BACKUP_DIR="$SCRIPT_DIR/backup"
mkdir -p "$BACKUP_DIR"

# Backup existing config.toml if it exists and is not already our symlink
if [ -e "$MISE_CONFIG" ]; then
  if [ -L "$MISE_CONFIG" ] && [ "$(readlink "$MISE_CONFIG")" = "$SCRIPT_DIR/config.toml" ]; then
    echo "Already linked: $MISE_CONFIG -> $(readlink "$MISE_CONFIG")"
    exit 0
  fi
  echo "Backing up existing config.toml to $BACKUP_DIR"
  cp "$MISE_CONFIG" "$BACKUP_DIR/config.toml.$(date +%Y%m%d%H%M%S)"
fi

# Ensure parent directory exists
mkdir -p "$(dirname "$MISE_CONFIG")"

# Create symbolic link
ln -sf "$SCRIPT_DIR/config.toml" "$MISE_CONFIG"
echo "Linked $MISE_CONFIG -> $SCRIPT_DIR/config.toml"
echo ""
echo "To install the tools, run:"
echo "  mise install"
