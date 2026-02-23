#!/bin/bash

NVIM_PATH=~/.config/nvim

[ -L "$NVIM_PATH" ] && unlink "$NVIM_PATH"
ln -s "$(dirname "$(dirname "$(realpath "$0")")")" ~/.config/nvim
