#!/bin/sh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

usage() {
  echo "Usage: $(basename "$0") --dest <path> [--dry-run]"
  echo ""
  echo "Options:"
  echo "  --dest <path>   インポート先のパス（必須）"
  echo "  --dry-run       実際には変更せず確認のみ"
  exit 1
}

DEST=""
DRY_RUN=""

while [ $# -gt 0 ]; do
  case "$1" in
    --dest)    DEST="$2"; shift 2 ;;
    --dry-run) DRY_RUN="--dry-run"; shift ;;
    *) usage ;;
  esac
done

if [ -z "$DEST" ]; then
  echo "Error: --dest が指定されていません"
  usage
fi

if [ ! -d "$DEST" ]; then
  echo "Error: インポート先が存在しません: $DEST"
  exit 1
fi

IGNORE_FILE="$DEST/.syncignore"
BACKUP_DIR="$DEST/backup/$(date +%Y%m%d%H%M%S)"

echo "インポート元: $SCRIPT_DIR"
echo "インポート先: $DEST"
if [ -n "$DRY_RUN" ]; then
  echo "[dry-run] 実際には変更しません"
fi
echo ""

# バックアップ
if [ -z "$DRY_RUN" ]; then
  echo "バックアップ: $BACKUP_DIR"
  cp -R "$DEST" "$BACKUP_DIR"
  echo ""
fi

RSYNC_OPTS="-av --delete"
if [ -f "$IGNORE_FILE" ]; then
  echo "無視ファイル: $IGNORE_FILE"
  RSYNC_OPTS="$RSYNC_OPTS --exclude-from=$IGNORE_FILE"
else
  echo "無視ファイルなし: $IGNORE_FILE が見つかりません（スキップ）"
fi
echo ""

# shellcheck disable=SC2086
rsync $RSYNC_OPTS $DRY_RUN "$SCRIPT_DIR/" "$DEST/"
