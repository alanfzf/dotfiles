#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# VARS
IS_WSL=$(grep -i Microsoft /proc/version)

# Do non wsl stuff
if [[ $IS_WSL ]]; then
  # Enable systemd
  sudo tee /etc/wsl.conf > /dev/null <<EOF
[boot]
systemd=true
EOF
fi

# Upgrade packages
sudo apt update && sudo apt upgrade -y

# Install base apps
sudo apt install -y \
  xclip zsh curl wget tmux bat \
  build-essential git gh \
  fzf fd-find ripgrep zoxide \
  zip unzip

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Create ssh dir
mkdir -p  ~/.ssh/
