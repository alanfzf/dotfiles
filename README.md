# Dot files
This repository contains some configuration files that i use to personalize my environment.

## Nix setup

```bash
mkdir -p ~/.config/nix && echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
nix shell nixpkgs#home-manager nixpkgs#git --command sh -c "\
	git clone https://github.com/alanfzf/dotfiles .dotfiles \
	&& home-manager switch --flake .dotfiles/.config/home-manager -b bckp"
```

## Linux Setup

```bash
# NOT recommended anymore
git clone https://github.com/alanfzf/dotfiles ~/.dotfiles
./install.sh
```

## Windows Setup

```powershell
# Enable script execution
Set-ExecutionPolicy Bypass
iwr https://raw.githubusercontent.com/alanfzf/dotfiles/master/install.ps1 | iex
```

### WSL setup

```powershell
# install wsl
wsl.exe --install --no-distribution
```
