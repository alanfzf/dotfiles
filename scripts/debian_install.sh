#!/bin/bash

sudo apt-get update && sudo apt-get -y upgrade

sudo apt-get install -y tmux git zsh build-essential curl wget gh zoxide zip unzip fzf fd-find ripgrep bat exa

# symlink magic
sudo ln -sf /usr/bin/batcat /usr/local/bin/bat
sudo ln -sf /bin/fdfind /usr/local/bin/fd
sudo ln -sf /usr/bin/exa /usr/local/bin/eza

# install neovim
curl -L "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz" | sudo tar xzf - -C /opt/
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

# install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -L "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" | sudo tar xzf - -C /usr/local/bin/
