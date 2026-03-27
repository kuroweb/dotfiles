#!/bin/sh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_BASE="$SCRIPT_DIR/backup/$(date +%Y%m%d%H%M%S)"

link_file() {
  relative_dir="$1"
  name="$2"
  source_file="$SCRIPT_DIR/$relative_dir/$name"
  target_file="$TARGET_CONFIG_HOME/$relative_dir/$name"
  backup_dir="$BACKUP_BASE/$relative_dir"

  if [ ! -f "$source_file" ]; then
    echo "Warning: Source file does not exist: $source_file (skipping)"
    return 0
  fi

  mkdir -p "$(dirname "$target_file")"

  if [ -e "$target_file" ] || [ -L "$target_file" ]; then
    if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
      echo "Already linked: $target_file -> $(readlink "$target_file")"
      return 0
    fi

    mkdir -p "$backup_dir"
    backup_file="$backup_dir/$name.$(date +%Y%m%d%H%M%S)"
    cp "$target_file" "$backup_file"
    echo "Backed up existing file: $target_file -> $backup_file"
  fi

  ln -sf "$source_file" "$target_file"
  echo "Linked $target_file -> $source_file"
}

echo "Setting up worktrunk..."
link_file "worktrunk" "config.toml"
