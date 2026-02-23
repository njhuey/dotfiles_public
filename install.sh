#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.config_backup"

# Install a symlink from src to dst.
# - If dst is an existing symlink, remove it.
# - If dst is an existing file/directory, move it to BACKUP_DIR preserving structure.
# - Then create the symlink.
install_link() {
    local src="$1"
    local dst="$2"

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        echo "Removing symlink:   $dst"
        unlink "$dst"
    elif [ -e "$dst" ]; then
        local rel_path="${dst#"$HOME/"}"
        local backup_path="$BACKUP_DIR/$rel_path"
        mkdir -p "$(dirname "$backup_path")"
        echo "Backing up file:    $dst -> $backup_path"
        mv "$dst" "$backup_path"
    fi

    ln -s "$src" "$dst"
    echo "Linked:             $src -> $dst"
}

install_link "$DOTFILES_DIR/zshrc"      "$HOME/.zshrc"
install_link "$DOTFILES_DIR/gitconfig"  "$HOME/.config/git/config"
install_link "$DOTFILES_DIR/tmux.conf"  "$HOME/.config/tmux/tmux.conf"
install_link "$DOTFILES_DIR/ghostty"    "$HOME/.config/ghostty/config"
install_link "$DOTFILES_DIR/gh.yml"     "$HOME/.config/gh/config.yml"
install_link "$DOTFILES_DIR/nvim"       "$HOME/.config/nvim"
