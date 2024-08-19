#!/bin/bash
#                   -`
#                  .o+`
#                 `ooo/
#                `+oooo:
#               `+oooooo:
#               -+oooooo+:
#             `/:-:++oooo+:
#            `/++++/+++++++:
#           `/++++++++++++++:
#          `/+++ooooooooooooo/`
#         ./ooosssso++osssssso+`
#        .oossssso-````/ossssss+`
#       -osssssso.      :ssssssso.
#      :osssssss/        osssso+++.
#     /ossssssss/        +ssssooo/-
#   `/ossssso+/:-        -:/+osssso+-
#  `+sso+:-`                 `.-/+oso:
# `++:.                           `-/+/
# .`                                 `/


# Set default apps: https://linux-tips.com/t/setting-default-browser-in-system/56/2
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
  sudo pacman -Syu --noconfirm thunar brightnessctl \
    bluez bluez-utils \
    ttf-jetbrains-mono-nerd \
    wofi mako wl-clipboard slurp grim

else
  # Symlink this for xdg-open
  sudo ln -s "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" /usr/local/bin
  # Generate locales
  sudo sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen
  sudo locale-gen
fi
