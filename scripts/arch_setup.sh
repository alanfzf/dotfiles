#!/bin/bash

# Configure notification-daemon: https://wiki.archlinux.org/title/Desktop_notifications
# Set default apps: https://linux-tips.com/t/setting-default-browser-in-system/56/2
# Configure audio: https://wiki.archlinux.org/title/Bluetooth#PipeWire
# Disable audio power saving: 
# sudo echo 0 > /sys/module/snd_hda_intel/parameters/power_save

# Install base packages
sudo pacman -S git curl wget tmux base-devel github-cli \
  zsh zoxide starship \
  zip unzip \
  fzf fd ripgrep bat \
  neovim
  
# Install os packages
sudo pacman -S picom kitty feh thunar brightnessctl \
  rofi notification-daemon cbatticon volumeicon \
  ttf-jetbrains-mono-nerd 
