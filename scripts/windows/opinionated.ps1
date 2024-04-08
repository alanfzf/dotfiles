#Requires -RunAsAdministrator

$nvimReg = @"
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shell\nvim]
@="Edit with Neovim"
; "Icon"="C:\\Users\\%USERNAME%\\AppData\\Local\\Programs\\Neovim\\bin\\nvim-qt.exe"
"Icon"="C:\\Program Files\\Neovim\\bin\\nvim-qt.exe"

[HKEY_CLASSES_ROOT\*\shell\nvim\command]
@="wt -p \"PowerShell\" --title Neovim nvim.exe \"%1\""
"@

# **** ADD NEOVIM TO CONTEXT MENU ****
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\nvim") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\*\shell\nvim" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\nvim\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\*\shell\nvim\command" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\nvim' -Name '(default)' -Value 'Edit with Neovim' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\nvim' -Name 'Icon' -Value 'C:\Program Files\Neovim\bin\nvim-qt.exe' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\nvim\command' -Name '(default)' -Value 'wt -p "PowerShell" --title Neovim nvim.exe "%1"' -PropertyType String -Force -ea SilentlyContinue;
