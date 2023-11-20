# Dot files
This repository contains some configuration files that i use to personalize my environment

## Linux Setup

```bash
# TODO:

```

## Windows Setup
<!-- ```bash
& ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString(''))) 'parameter'
``` -->

```powershell
# If you don't have Powershell 7 and Windows Terminal, you need to install them first
Set-ExecutionPolicy Bypass
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/alanfvn/dot-files/master/scripts/install_basics.ps1'))
```

```powershell
# enable script execution
Set-ExecutionPolicy Bypass
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/alanfvn/dot-files/master/install.ps1'))
```
