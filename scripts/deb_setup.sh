#!/bin/bash
#         _,met$$$$$gg.
#      ,g$$$$$$$$$$$$$$$P.
#    ,g$$P""       """Y$$.".
#   ,$$P'              `$$$.
# ',$$P       ,ggs.     `$$b:
# `d$$'     ,$P"'   .    $$$
#  $$P      d$'     ,    $$P
#  $$:      $$.   -    ,d$$'
#  $$;      Y$b._   _,d$P'
#  Y$$.    `.`"Y$$$$P"'
#  `$$b      "-.__
#   `Y$$b
#    `Y$$.
#      `$$b.
#        `Y$$b.
#          `"Y$b._
#              `""""

# Upgrade packages
sudo apt update && apt upgrade -y

# Install base apps
sudo apt install -y \
  zsh curl wget bat \
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
curl -fsSL https://starship.rs/install.sh | sh -s -- --yes

# 4.) Eza
sudo curl -L "https://github.com/eza-community/eza/releases/download/v0.18.17/eza_x86_64-unknown-linux-gnu.tar.gz" | tar xzf - -C /usr/local/bin/
