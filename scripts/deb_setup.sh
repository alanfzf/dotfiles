#!/bin/bash

# VARS
IS_WSL=$(grep -i Microsoft /proc/version)

# Do non wsl stuff
if [[ $IS_WSL ]]; then
  # Enable systemd
  sudo tee /etc/wsl.conf > /dev/null <<EOF
[boot]
systemd=true
EOF

# Symlink this for xdg-open
sudo ln -s "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" /usr/local/bin
fi

# Upgrade packages
sudo apt update && sudo apt upgrade -y

# Install base apps
sudo apt install -y \
  xclip zsh curl wget tmux bat \
  build-essential git gh \
  fzf fd-find ripgrep zoxide \
  zip unzip

# === Install non apt packages ===
# 1.) Neovim
curl -L "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz" | sudo tar xzf - -C /opt/
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

# 2.) Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -L "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" | sudo tar xzf - -C /usr/local/bin/

# 3.) Starship
curl -L "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz" | sudo tar xzf - -C /usr/local/bin/

# 4.) Eza
curl -L "https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz" | sudo tar xzf - -C /usr/local/bin/

# Create SSH dir
mkdir -p  ~/.ssh/
