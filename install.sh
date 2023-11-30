sed -i "/^deb cdrom:/s/^/#/" /etc/apt/sources.list

sudo apt update
sudo apt install build-essential -y
sudo apt install pulseaudio pavucontrol kitty feh
