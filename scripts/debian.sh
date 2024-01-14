#!/bin/bash

TEMPDIR=$(mktemp -d)
NERDURL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"

# Basic window manager stuff 
sudo apt install -y xorg xserver-xorg xclip python3 python3-pip python3-venv python3-v-sim python-dbus-dev libpangocairo-1.0-0 python3-xcffib python3-cairocffi libxkbcommon-dev libxkbcommon-x11-dev 

# Basic opearting system stuff and greeter
sudo apt install -y lightdm slick-greeter picom gvfs-backends pipewire pipewire-pulse 

# Install os management related apps
sudo apt install -y fish thunar kitty feh scrot brightnessctl pulseaudio rofi

# Install tools
sudo apt install -y wget curl fuse build-essential git gh fzf fd-find nodejs npm tmux bat ripgrep

cd $TEMPDIR

# Install a nerd font
wget "$NERDURL" -O font.tar.xz 
tar -xvf font.tar.xz -C $TEMPDIR
sudo mv *.ttf /usr/share/fonts/
sudo fc-cache -f -v

# Make GRUB not boot automatically
sudo sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' /etc/default/grub
sudo update-grub

# Fix WiFi
# sudo sed -i 's/managed=false/managed=true/' /etc/NetworkManager/NetworkManager.conf
# sudo apt remove ifupdown
# systemctl restart network-manager

# Enable Bluetooth
systemctl --user --now enable pipewire pipewire-pulse

# Create desktop entry for qtile
sudo cat > /usr/share/xsessions/qtile.desktop << EOF
[Desktop Entry]
Name=qtile
Exec=qtile start
Type=Application
Keywords=wm;tiling
EOF

# Load programs at startup
sudo cat > ~/.xsessionrc <<EOF
setxkbmap -option ctrl:nocaps
picom &
~/.fehbg
EOF
