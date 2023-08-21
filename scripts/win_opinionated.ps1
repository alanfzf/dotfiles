if(!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
   Write-Host "You must run this script as Administrator!"  -ForegroundColor Red
   Exit
}
# ORIGINAL REGEDITS
$nvimReg = @"
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shell\nvim]
@="Edit with Neovim"
; "Icon"="C:\\Users\\%USERNAME%\\AppData\\Local\\Programs\\Neovim\\bin\\nvim-qt.exe"
"Icon"="C:\\Program Files\\Neovim\\bin\\nvim-qt.exe"

[HKEY_CLASSES_ROOT\*\shell\nvim\command]
@="wt -p \"PowerShell\" --title Neovim nvim.exe \"%1\""
"@

$ctrlReg = @"
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
"Scancode Map"=hex:00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00
"@

# **** ADD NEOVIM TO CONTEXT MENU ****
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\nvim") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\*\shell\nvim" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\nvim\command") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\*\shell\nvim\command" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\nvim' -Name '(default)' -Value 'Edit with Neovim' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\nvim' -Name 'Icon' -Value 'C:\Program Files\Neovim\bin\nvim-qt.exe' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\nvim\command' -Name '(default)' -Value 'wt -p "PowerShell" --title Neovim nvim.exe "%1"' -PropertyType String -Force -ea SilentlyContinue;

# **** REMAP CAPS LOCK TO CTRL ****
# $RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout"
# Set-ItemProperty -Path $RegistryPath -Name "Scancode Map" -Value [byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x1d,0x00,0x3a,0x00,0x00,0x00,0x00,0x00) 
