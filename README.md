# Dot files
This repository contains some configuration files that i use to personalize my environment.

## Linux Setup

```bash
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
# install arch wsl
winget.exe install -e --id 9MZNMNKSM73X
```

```bash
# install this to make zathura and dropbox work
sudo pacman -Syu qt5-base xcb-util libxdamage
```
