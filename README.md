# Windows dot files

This repository contains some configuration files that i use to personalize my Windows environment

Use the following script to automatically setup this configuration. (It requires administrator privileges!)

```bash
& ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://gist.githubusercontent.com/alanfvn/60347924cd3e8d5c1e6fd69f710e6ffb/raw/first_win_setup.ps1'))) 'dotfiles'
```
