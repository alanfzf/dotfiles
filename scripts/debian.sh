#!/bin/bash

TEMPDIR=$(mktemp -d)
NERDURL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"

# Install window manager stuff, NOTE: pipx is used for qtile
sudo apt install -y --no-install-recommends xserver-xorg-core xserver-xorg-input-libinput xinit xclip lightdm slick-greeter picom pipx gvfs-backends
# Bluetooth related
sudo apt install pipewire pipewire-pulse

# pipx install qtile

# Install tools
sudo apt install -y wget curl fuse build-essential git

# Install os management related apps
sudo apt install -y thunar kitty feh scrot brightnessctl pulseaudio rofi

# Install other apps
sudo apt install -y gh fzf fd-find nodejs npm tmux bat

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
sed -i 's/managed=false/managed=true/' /etc/NetworkManager/NetworkManager.conf
sudo apt remove ifupdown
systemctl restart network-manager

# Enable Bluetooth
systemctl --user --now enable pipewire pipewire-pulse

# Create desktop entry for qtile
sudo cat > /usr/share/xsessions/qtile.desktop << EOF
[Desktop Entry]
Name=qtile
Exec=/home/user/.local/bin/qtile start
Type=Application
Keywords=wm;tiling
EOF

# Make GTK use a dark theme by default
cat > ~/.config/gtk-3.0/settings.ini <<EOF
[Settings]
gtk-application-prefer-dark-theme=1
EOF

# Load programs at startup
cat > ~/.xsessionrc <<EOF
setxkbmap -option ctrl:nocaps
picom &
~/.fehbg
EOF
