#!/bin/bash

# Install sudo
pacman -Syu --noconfirm sudo nix

# Create user alan with home directory and bash shell
useradd -m -G wheel -s /bin/bash alan

# Set password for alan (will ask interactively)
passwd alan

# Enable wheel group in sudoers automatically
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Uncomment en_US.UTF-8 locale
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen

# Generate locales
locale-gen

cat <<EOF >> /etc/wsl.conf
[user]
default=alan
EOF
