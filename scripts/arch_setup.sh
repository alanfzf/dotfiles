#!/bin/bash

# Configure notification-daemon: https://wiki.archlinux.org/title/Desktop_notifications
# Set default apps: https://linux-tips.com/t/setting-default-browser-in-system/56/2
# Configure audio: https://wiki.archlinux.org/title/Bluetooth#PipeWire
# Disable audio power saving: 
# sudo echo 0 > /sys/module/snd_hda_intel/parameters/power_save
# fix x11 display wsl: https://github.com/microsoft/wslg/issues/43#issuecomment-826039096
# fix locale zsh stuck completion: https://stackoverflow.com/a/20953792/20370244

IS_WSL=$(grep -i Microsoft /proc/version)

# Install base packages
sudo pacman -Syu --noconfirm git curl wget tmux base-devel github-cli \
  zsh zoxide starship \
  zip unzip \
  fzf fd ripgrep bat \
  neovim eza lazygit

if [[ ! $IS_WSL ]]; then
  # Install os packages
  sudo pacman -Syu --noconfirm picom kitty feh thunar brightnessctl \
    rofi notification-daemon cbatticon volumeicon \
    ttf-jetbrains-mono-nerd
else
  # Symlink this for xdg-open
  sudo ln -s "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" /usr/local/bin
fi
