#!/bin/bash

sudo apt update && \
	sudo apt upgrade -y && \
	sudo apt install curl xz-utils openssh-client uidmap -y

curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes
