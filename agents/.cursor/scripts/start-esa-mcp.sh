#!/bin/bash

ENV_FILE="$HOME/.cursor/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "Error: .env file not found at $ENV_FILE" >&2
  exit 1
fi

# .envファイルからトークンを読み込む
source "$ENV_FILE"

docker run --rm -i \
  -e ESA_ACCESS_TOKEN="$ESA_ACCESS_TOKEN" \
  -e ESA_TEAM_NAME="$ESA_TEAM_NAME" \
  ghcr.io/esaio/esa-mcp-server
