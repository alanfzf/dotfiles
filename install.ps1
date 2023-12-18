#Requires -RunAsAdministrator
#Requires -Version 5.0

# =====================
# * CONSTANTS *
# =====================
$temp = "$env:TEMP/files/"
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/jetbrainsmono.zip"
New-Item -ItemType Directory -Path $temp -Force

# =======================
# * Handle Powershell 5 *
# =======================
if($PSVersionTable.PSVersion.Major -lt 7){
  $wingetFile = Join-Path $temp "winget.msixbundle"
  (New-Object Net.WebClient).DownloadFile("https://aka.ms/getwinget", $wingetFile);
  Add-AppxPackage $wingetFile;
  @("Microsoft.PowerShell", "Microsoft.WindowsTerminal") | ForEach-Object { winget install -e --accept-source-agreements --accept-package-agreements --silent $_ }
  Read-Host -Prompt "Successfully installed requirmenets, please re-launch this script with Windows Terminal and Powershell-7..." | Out-Null
  Exit
}

# =====================
# * UTILITY FUNCTIONS *
# =====================
function DownloadAndDecompress {
  param(
      [String]$Url, 
      [Switch]$CreateFolder
  )

  $fileName = [System.IO.Path]::GetFileName($Url)
  $outFile = Join-Path $temp $fileName
  $outputFolder = $temp

  (New-Object Net.WebClient).DownloadFile($Url, $outFile)

  if($CreateFolder){
    $folderName = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    $outputFolder = Join-Path $outputFolder $folderName
  }
  & "${env:ProgramFiles}\7-Zip\7z.exe" x $outFile "-o$outputFolder" -y | Out-Null

  # Return the latest created folder
  return Get-ChildItem -Path $temp -Directory | Sort-Object CreationTime -Descending | Select-Object -First 1
}

function InstallFonts {
  param ([String]$fontFolder)
  $destFolder = (New-Object -ComObject Shell.Application).Namespace(0x14)
  $foundFonts = Get-ChildItem -Path "$fontFolder/*" -Include '*.ttf','*.ttc','*.otf' -Recurse 

  foreach($font in $foundFonts){
    $fontFullName = $font.FullName
    $fontName = $font.Name
    if(Test-Path "C:\Windows\Fonts\$fontName"){ continue }
    $destFolder.CopyHere($fontFullName, 0x10)
  }
}

function CleanTemp {
  Get-ChildItem -Path $temp -Force | ForEach-Object { $_ | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue }
}

# =====================
# * SETUP FUNCTIONS *
# =====================
function InstallPrograms {
  # **** INSTALL WINGET PACKAGES ****
  $Packages = @(
    "7zip.7zip"
    "BurntSushi.ripgrep.MSVC"
    "Discord.Discord" 
    "Neovim.Neovim"
    "OpenJS.NodeJS"
    "Python.Python.3.9"
    "Starship.Starship"
    "VideoLAN.VLC"
    "JesseDuffield.lazygit"
    "sharkdp.fd"
    "junegunn.fzf"
    "sharkdp.bat"
    "eza-community.eza"
    "Microsoft.PowerToys"
  )
  # The override parameters make git not add itself to the context menu
  winget install -e --accept-source-agreements --accept-package-agreements --silent Git.Git --override "/VERYSILENT /COMPONENTS="
  foreach ($package in $packages) { winget install -e --accept-source-agreements --accept-package-agreements --silent $package }
  # **** INSTALL NON WINGET STUFF ****
  $fontFolder = DownloadAndDecompress $fontUrl -CreateFolder
  InstallFonts $fontFolder.FullName
}

function InstallPSModules {
  Install-Module -Name z -Confirm:$False -Force
}

function SetupDotFiles{
  # Git related stuff
  $gitCmd = "${env:ProgramFiles}\Git\bin\git.exe"
  $dotfiles = "$HOME/dotfiles/"
  & $gitCmd clone "https://github.com/alanfzf/dotfiles" $dotfiles

  # weird fucking paths
  $wtPath = Get-ChildItem "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_*" | Select-Object -First 1 -Expand FullName
  $wtPath =  "$wtPath/LocalState/"
  $profilePath = Split-Path -Path $PROFILE -Parent

  # **** CREATE SYMLINKS ****
  $symLinks = @{
    # realPath = targetPath
    "$env:LOCALAPPDATA/nvim/" = "$dotfiles/.config/nvim/"
    "$env:APPDATA/lazygit/"   = "$dotfiles/.config/lazygit/"
    "$wtPath"                 = "$dotfiles/.config/windows_terminal/"
    "$profilePath"            = "$dotfiles/.config/windows_powershell/"
    "$HOME/starship.toml"     = "$dotfiles/.config/starship.toml"
    "$HOME/.ideavimrc"        = "$dotfiles/.ideavimrc"
    "$HOME/.vsvimrc"          = "$dotfiles/.vsvimrc"
  }

  foreach ($entry in $symLinks.GetEnumerator()) {
    $symPath = $entry.Key;
    $symTarget = $entry.Value;
    Remove-Item -Path $symPath -Force -Recurse;
    New-Item -ItemType SymbolicLink -Path $symPath -Target $symTarget -Force
  }
}

function WindowsTweaks {
  $RegPathCM = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" 
  $RegPathEx = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
  $RegPathTheme = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" 
  $RegPathExCurrent = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" 
  $RegPathDate = "HKCU:\Control Panel\International"

  # **** UI Tweaks **** 
  # Activate old context menu 
  New-Item -Path $RegPathCM -Force | Out-Null
  Set-ItemProperty -Path $RegPathCM -Name "(default)" -Value "" -Force
  # Deactivate bing search 
  New-Item -Path $RegPathEx -Force | Out-Null
  Set-ItemProperty -Path $RegPathEx -Name "DisableSearchBoxSuggestions" -Value 1
  # Multitasking view disable multiple tabs
  Set-ItemProperty -Path $RegPathEx -Name "MultiTaskingAltTabFilter" -Type Dword -Value "4"
  # Hide frequent folders
  Set-ItemProperty "$RegPathExCurrent" -Name ShowFrequent -Value 0
  # Show file extensions
  Set-ItemProperty "$RegPathExCurrent\Advanced" -Name HideFileExt -Value 0
  # Enable dark mode 
  Set-ItemProperty -Path $RegPathTheme -Name "SystemUsesLightTheme" -Type DWord -Value 0
  Set-ItemProperty -Path $RegPathTheme -Name "AppsUseLightTheme" -Type DWord -Value 0

  # **** TASKBAR TWEAKS **** 
  # Remove task view from taskbar
  Set-ItemProperty -Path "$RegPathExCurrent\Advanced" -Name "ShowTaskViewButton" -type "Dword" -Value "0"
  # Remove chat from taskbar
  Set-ItemProperty -Path "$RegPathExCurrent\Advanced" -Name "TaskbarMn" -type "Dword" -Value "0"
  # Remove widgets from taskbar
  Set-ItemProperty -Path "$RegPathExCurrent\Advanced" -Name "TaskbarDa" -type "Dword" -Value "0"
  # Remove search from taskbar
  Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -type "Dword" -Value "0"
  # Unpin taskbar icons
  Set-ItemProperty -Path "$RegPathExCurrent\Taskband" -Name "Favorites" -Type Binary -Value ([byte[]](255))
  Remove-ItemProperty -Path "$RegPathExCurrent\Taskband" -Name "FavoritesResolve" -ErrorAction SilentlyContinue

  # **** DATE TWEAKS **** 
  Set-ItemProperty -Path $RegPathDate -Name sShortDate -Value "yyyy-MM-dd";
  Set-ItemProperty -Path $RegPathDate -Name sShortTime -Value "HH:mm";

  # **** ENABLE DEV MODE *****
  reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
}

function RemovePrograms{
  $MsCrap = @(
    "Clipchamp.Clipchamp"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingWeather"
    "Microsoft.GamingApp"
    "Microsoft.GetHelp"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.Paint"
    "Microsoft.People"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Todos"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsNotepad"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "MicrosoftCorporationII.QuickAssist"
    "MicrosoftTeams"
    "getstarted"
    "microsoft.windowscommunicationsapps"
  )
  foreach ($package in $MsCrap){
    Get-AppxPackage -AllUsers "*$package*" | Remove-AppxPackage
    Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -Like "*$package*"} | ForEach-Object {
      Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName
    }
  }
}

# =====================
# DO THE SETUP
# =====================
InstallPrograms
InstallPSModules
SetupDotFiles
WindowsTweaks
RemovePrograms
CleanTemp
Stop-Process -ProcessName explorer
