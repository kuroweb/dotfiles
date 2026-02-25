#!/bin/sh
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ファイルのシンボリックリンクを作成する関数
link_file() {
  local target_dir="$1"
  local name="$2"
  local src="$SCRIPT_DIR/$target_dir/$name"
  local dest="$HOME/$target_dir/$name"
  local backup_dir="$SCRIPT_DIR/backup/$target_dir"

  if [ -e "$dest" ]; then
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
      echo "Already linked: $dest -> $(readlink "$dest")"
    else
      mkdir -p "$backup_dir"
      echo "Backing up existing $name to $backup_dir"
      cp "$dest" "$backup_dir/$name.$(date +%Y%m%d%H%M%S)"
      ln -sf "$src" "$dest"
      echo "Linked $dest -> $src"
    fi
  else
    ln -sf "$src" "$dest"
    echo "Linked $dest -> $src"
  fi
}

# ディレクトリのシンボリックリンクを作成する関数
link_directory() {
  local target_dir="$1"
  local name="$2"
  local src="$SCRIPT_DIR/$target_dir/$name"
  local dest="$HOME/$target_dir/$name"
  local backup_dir="$SCRIPT_DIR/backup/$target_dir"

  if [ -e "$dest" ]; then
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
      echo "Already linked: $dest -> $(readlink "$dest")"
    else
      mkdir -p "$backup_dir"
      echo "Backing up existing $name directory to $backup_dir"
      cp -R "$dest" "$backup_dir/$name.$(date +%Y%m%d%H%M%S)"
      rm -rf "$dest"
      ln -sf "$src" "$dest"
      echo "Linked $dest -> $src"
    fi
  else
    ln -sf "$src" "$dest"
    echo "Linked $dest -> $src"
  fi
}

# ~/.claude にシンボリックリンクを作成
echo "Setting up .claude..."
mkdir -p "$HOME/.claude"
link_file ".claude" "settings.json"
link_file ".claude" "settings.local.json"
link_directory ".claude" "rules"
link_directory ".claude" "scripts"
link_directory ".claude" "skills"
link_directory ".claude" "agents"
echo ""

# ~/.cursor にシンボリックリンクを作成
echo "Setting up .cursor..."
mkdir -p "$HOME/.cursor"
link_directory ".cursor" "rules"
link_directory ".cursor" "scripts"
link_directory ".cursor" "skills"
link_directory ".cursor" "agents"
