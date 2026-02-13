#!/bin/sh
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CURSOR_SETTING_DIR=~/Library/Application\ Support/Cursor/User

# Create backup directory
BACKUP_DIR="$SCRIPT_DIR/backup"
mkdir -p "$BACKUP_DIR"

# Backup settings and keybindings
cp "$CURSOR_SETTING_DIR/settings.json" "$BACKUP_DIR"
cp "$CURSOR_SETTING_DIR/keybindings.json" "$BACKUP_DIR"
cursor --list-extensions > "$BACKUP_DIR/extensions"

# Create symbolic links for settings and keybindings
ln -sf "$SCRIPT_DIR/settings.json" "${CURSOR_SETTING_DIR}/settings.json"
ln -sf "$SCRIPT_DIR/keybindings.json" "${CURSOR_SETTING_DIR}/keybindings.json"

# Install extensions from file
while read -r line
do
  cursor --install-extension "$line"
done < "$SCRIPT_DIR/extensions"

# Update list of installed extensions
cursor --list-extensions > "$SCRIPT_DIR/extensions"
