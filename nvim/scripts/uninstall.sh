#!/bin/bash

NVIM_PATH=~/.config/nvim

[ -L "$NVIM_PATH" ] && unlink "$NVIM_PATH"
ln -s ~/.dotfiles/nvim ~/.config/nvim  # adjust path if repo is not at ~/.dotfiles
