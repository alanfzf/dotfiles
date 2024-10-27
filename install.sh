#!/bin/bash

# Get location where this script resides
DOTFILES=$(dirname $(readlink -f $0))
DOT_CONFIG="$DOTFILES/.config"
# Targets
DOT_HOME="$HOME/.config"

# Pre setup
mkdir -p $DOT_HOME

# Install simple dotfiles
find "$DOTFILES" -maxdepth 1 -type f -name ".*" | while read -r source; do
  rm -rf "$HOME/$(basename $source)"
  ln -sf "$source" "$HOME"
done

# Install dotfiles on XDG_CONFIG_HOME
find "$DOT_CONFIG" -mindepth 1 -maxdepth 1 | while read -r source; do
  rm -rf "$DOT_HOME/$(basename $source)"
  ln -sf "$source" "$DOT_HOME"
done
