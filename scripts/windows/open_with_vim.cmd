set "vidir=%1"
set "vidir=%vidir:\=/%"
wsl.exe nvim -p $(wsl.exe wslpath %vidir%)
