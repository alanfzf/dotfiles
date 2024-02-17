#!/bin/bash

DOTFILES="$(dirname "$(readlink -f "$0")")"
IGNORE="$DOTFILES/.ignore-slink"

find $DOTFILES -maxdepth 1 -type f | grep -vf "$IGNORE" | while read source; do
  target="$HOME/$(basename $source)"
  rm -rf $target
  ln -sf $source $target
done

# create .config dir
mkdir -p "$HOME/.config/"

find "$DOTFILES/.config/" -mindepth 1 -maxdepth 1 | while read source; do
  target="$HOME/.config/$(basename $source)"
  rm -rf $target
  ln -sf $source $target
done
