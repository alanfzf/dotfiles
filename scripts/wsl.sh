#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install -y git \
	curl wget \
	tmux \
	build-essential \
	zip unzip \
	zsh \
	zoxide \
	python3 \
	fzf \
	fd-find \
	ripgrep \
	bat

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

# install starship
curl -sS https://starship.rs/install.sh | sh

# enable systemd
sudo tee /etc/wsl.conf > /dev/null <<EOF
[boot]
systemd=true
EOF

# sudo chsh -s $(which zsh)
