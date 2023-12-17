#!/bin/bash

DOTFILES="$(dirname "$(readlink -f "$0")")"
DOTS=(".xsessionrc" ".tmux.conf" ".ideavimrc")

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

#sed -i "/^deb cdrom:/s/^/#/" /etc/apt/sources.list
#sudo apt update
#sudo apt install build-essential -y
#sudo apt install pulseaudio pavucontrol kitty feh
