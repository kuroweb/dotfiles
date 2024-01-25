#!/bin/sh
SCRIPT_DIR=$(pwd)
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

# Create backup directory
BACKUP_DIR="$SCRIPT_DIR/backup/vscode"
mkdir -p "$BACKUP_DIR"

# Backup settings and keybindings
cp "$VSCODE_SETTING_DIR/settings.json" "$BACKUP_DIR"
cp "$VSCODE_SETTING_DIR/keybindings.json" "$BACKUP_DIR"
code --list-extensions > "$BACKUP_DIR/extensions"

# Create symbolic links for settings and keybindings
ln -sf "$SCRIPT_DIR/settings.json" "${VSCODE_SETTING_DIR}/settings.json"
ln -sf "$SCRIPT_DIR/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

# Install extensions from file
while read -r line
do
  code --install-extension "$line"
done < ./extensions

# Update list of installed extensions
code --list-extensions > extensions
