#!/bin/bash

IS_WSL=$(grep -i Microsoft /proc/version)


# Install non wsl packages
if [[ ! $IS_WSL ]]; then
fi


# enable systemd
# sudo tee /etc/wsl.conf > /dev/null <<EOF
# [boot]
# systemd=true
# EOF
