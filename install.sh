sed -i "/^deb cdrom:/s/^/#/" /etc/apt/sources.list

sudo apt update
sudo apt install build-essential -y

# sudo apt install xorg lightdm slick-greeter lightdm-settings lxappearance nitrogen pcmanfm chromium pulseaudio alsa-utils pavucontrol kitty
