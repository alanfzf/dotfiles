# Dot files
This repository contains some configuration files that i use to personalize my environment.

## Linux Setup

```bash
git clone https://github.com/alanfzf/dotfiles ~/.dotfiles
stow -d ~/.dotfiles .
```

## Windows Setup
<!-- 
```bash
& ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString(''))) 'parameter'
``` 
-->

```powershell
# Enable script execution
Set-ExecutionPolicy Bypass
iwr https://raw.githubusercontent.com/alanfzf/dotfiles/master/install.ps1 | iex
```
