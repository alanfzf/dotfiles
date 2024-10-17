set "vidir=%1"
set "vidir=%vidir:\=/%"
wsl.exe sudo nvim -p $(wsl.exe wslpath %vidir%)
