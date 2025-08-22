@echo off
set "vidir=%~1"
set "vidir=%vidir:\=/%"
wsl.exe /bin/bash -ic "nvim -p '$(wsl.exe wslpath '%vidir%')'"
