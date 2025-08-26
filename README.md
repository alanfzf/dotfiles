# Dot files

This repository contains some configuration files that i use to personalize my environment.

## Linux setup

```bash
bash <(curl -s https://alanfzf.github.io/dotfiles/scripts/linux.sh)
```

## Windows Setup

```powershell
Set-ExecutionPolicy Bypass -Force
iwr https://alanfzf.github.io/dotfiles/install.ps1 | iex
```

### WSL setup

```powershell
# install WSL
wsl.exe --install --no-distribution
```
