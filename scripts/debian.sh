#!/bin/bash

# Fix Wifi: https://www.reddit.com/r/debian/s/8V6hVfU8x1

# DIRS
TEMPDIR=$(mktemp -d)
QTDIR="$HOME/.local/src/"
# URLS
NERDURL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
QTURL="https://github.com/qtile/qtile"

# Basic window manager stuff 
sudo apt install -y \
  xorg xserver-xorg xclip \
  python3 python3-pip python3-venv python3-v-sim python-dbus-dev \
  libpangocairo-1.0-0 python3-xcffib python3-cairocffi \
  libxkbcommon-dev libxkbcommon-x11-dev

# Basic operating system stuff
sudo apt install -y \
  lightdm slick-greeter picom gvfs-backends \
  pipewire pipewire-pulse

# Os management related apps
sudo apt install -y \
  zsh thunar kitty feh scrot \
  brightnessctl pulseaudio rofi volumeicon-alsa notification-daemon cbatticon

# Tools
sudo apt install -y \
  curl fuse build-essential git gh fzf \
  fd-find nodejs npm tmux bat ripgrep zoxide

cd $TEMPDIR

# Install a nerd font
curl -Lo font.tar.xz "$NERDURL"
tar -xvf font.tar.xz -C $TEMPDIR
sudo mv *.ttf /usr/share/fonts/
sudo fc-cache -f -v


# Create desktop entry for qtile
sudo tee /usr/share/xsessions/qtile.desktop << EOF > /dev/null
[Desktop Entry]
Name=qtile
Exec=qtile start
Type=Application
Keywords=wm;tiling
EOF

# Disable audio power saving
sudo echo 0 > /sys/module/snd_hda_intel/parameters/power_save

# Enable Bluetooth
sudo systemctl --user --now enable pipewire pipewire-pulse

# **** INSTALL QTILE ****
mkdir -p $QTDIR
cd $QTDIR
python3 -m venv qtile_venv
cd ./qtile_venv
git clone $QTURL
./bin/pip install qtile/.
cp ./bin/qtile /usr/local/bin/
