# Dot files

This repository contains some configuration files that i use to personalize my environment.

## Linux setup

```bash
mkdir -p ~/.config/nix && echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
nix shell nixpkgs#home-manager nixpkgs#git --command sh -c "\
	git clone https://github.com/alanfzf/dotfiles $HOME/.dotfiles \
	&& home-manager switch --flake $HOME/.dotfiles/config/nixos -b bckp"
```

## Windows Setup

```powershell
Set-ExecutionPolicy Bypass
iwr https://raw.githubusercontent.com/alanfzf/dotfiles/master/install.ps1 | iex
```

### WSL setup

```powershell
# install wsl
wsl.exe --install --no-distribution
```
### Alacritty local

```toml
[terminal.shell]
  program = "wsl"
  args = ["--cd ~"]
```
