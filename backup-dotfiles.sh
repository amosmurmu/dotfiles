#!/bin/sh

# Destination backup folder
BACKUP_DIR="$HOME/dotfiles-backup/$(date +%Y-%m-%d_%H-%M-%S)"
mkdir -p "$BACKUP_DIR"

echo "🔄 Backing up existing dotfiles to $BACKUP_DIR..."

# List of dotfiles and config dirs to back up
FILES_TO_BACKUP="
.bashrc
.zshrc
.gitconfig
.tmux.conf
.tmux
.config/nvim
"

for file in $FILES_TO_BACKUP; do
  SRC="$HOME/$file"
  DEST="$BACKUP_DIR/$file"

  if [ -e "$SRC" ] || [ -L "$SRC" ]; then
    echo "📦 Backing up $SRC → $DEST"
    mkdir -p "$(dirname "$DEST")"
    mv "$SRC" "$DEST"
  else
    echo "⚠️  Skipping $SRC (not found)"
  fi
done

echo "✅ Backup complete."
echo "🗃️  All files saved in: $BACKUP_DIR"
