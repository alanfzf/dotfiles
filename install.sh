#!/bin/bash

DOTFILES="$(dirname "$(readlink -f "$0")")"
DOTS=(".xsessionrc" ".tmux.conf" ".ideavimrc" ".zshrc" ".latexmkrc")

# ***** SETUP DOTFILES *****
for item in "$DOTFILES/.config"/*; do
  name=$(basename "$item")
  target="$HOME/.config/$name"

  rm -rf "$target"
  ln -sf "$item" "$target"
done


for item in "${DOTS[@]}"; do
  source="$DOTFILES/$item"
  target="$HOME/$item"

  rm -rf "$target"
  ln -sf "$source" "$target"
done
