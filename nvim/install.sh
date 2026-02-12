#!/bin/sh
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# Create backup directory
BACKUP_DIR="$SCRIPT_DIR/backup"
mkdir -p "$BACKUP_DIR"

# Backup existing config if it exists and is not already our symlink
if [ -e "$NVIM_CONFIG_DIR" ]; then
  if [ -L "$NVIM_CONFIG_DIR" ]; then
    echo "Already linked: $NVIM_CONFIG_DIR -> $(readlink "$NVIM_CONFIG_DIR")"
    exit 0
  fi
  echo "Backing up existing nvim config to $BACKUP_DIR"
  cp -R "$NVIM_CONFIG_DIR" "$BACKUP_DIR/nvim.$(date +%Y%m%d%H%M%S)"
  rm -rf "$NVIM_CONFIG_DIR"
fi

# Ensure parent directory exists
mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"

# Create symbolic link to this dotfiles nvim directory
ln -sf "$SCRIPT_DIR" "$NVIM_CONFIG_DIR"
echo "Linked $NVIM_CONFIG_DIR -> $SCRIPT_DIR"
