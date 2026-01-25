#!/bin/bash
# Usage: bash install.sh ~/path/to/project

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <project-path>"
  exit 1
fi

PROJECT_PATH="$1"
DOTFILES_CURSOR_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$PROJECT_PATH" ]; then
  echo "Error: Directory '$PROJECT_PATH' does not exist"
  exit 1
fi

cd "$PROJECT_PATH"

mkdir -p .cursor/rules .cursor/commands .cursor/skills .cursor/agents .cursor/contexts .cursor/hooks

ln -sf "$DOTFILES_CURSOR_DIR/rules" .cursor/rules/common
ln -sf "$DOTFILES_CURSOR_DIR/commands" .cursor/commands/common
ln -sf "$DOTFILES_CURSOR_DIR/skills" .cursor/skills/common
ln -sf "$DOTFILES_CURSOR_DIR/agents" .cursor/agents/common
ln -sf "$DOTFILES_CURSOR_DIR/contexts" .cursor/contexts/common
ln -sf "$DOTFILES_CURSOR_DIR/hooks" .cursor/hooks/common

echo "Symlinks created in $PROJECT_PATH/.cursor/"
