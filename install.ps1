#Requires -RunAsAdministrator
#Requires -Version 5.0

# =====================
# * CONSTANTS *
# =====================
$apps = "C:/Apps"
$temp = "$env:TEMP/files/"
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/jetbrainsmono.zip"
$mingwUrl = "https://github.com/skeeto/w64devkit/releases/download/v1.21.0/w64devkit-1.21.0.zip"
$altGrUrl = "https://github.com/thomasfaingnaert/win-us-intl-altgr/releases/download/v1.0/us-inter.zip"

New-Item -ItemType Directory -Path $apps -Force | Out-Null
New-Item -ItemType Directory -Path $temp -Force | Out-Null

# =====================
# * UTILITY FUNCTIONS *
# =====================
function DownloadAndDecompress {
  param(
      [String]$Url, 
      [Switch]$CreateFolder
  )

  $fileName = [System.IO.Path]::GetFileName($Url)
  $fileNameNoExt = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
  $outFile = "$temp/$fileName"
  $outFolder = "$temp/$fileNameNoExt"


  curl.exe -Lo $outFile $Url
  Expand-Archive $outFile -DestinationPath $outFolder -Force

  if($CreateFolder){
    # if there's a need to create a folder, we search in the temp directory 
    # otherwise we search the first folder inside the outFolder
    # NOTE: this only works if extracted archives are single directory
    $outFolder = $temp;
  }

  return Get-ChildItem -Path $outFolder -Directory | Sort-Object CreationTime -Descending | Select-Object -First 1
}

function InstallFonts {
  param ([String]$fontFolder)
  $destFolder = (New-Object -ComObject Shell.Application).Namespace(0x14)
  $foundFonts = Get-ChildItem -Path "$fontFolder/*" -Include '*.ttf','*.ttc','*.otf' -Recurse 
  $systemFontsPath = "$env:LOCALAPPDATA/Microsoft/Windows/Fonts"

  foreach($fontFile in $foundFonts){
    $fontDestPath = Join-Path $systemFontsPath $fontFile.Name
    if(Test-Path -Path $fontDestPath){ continue }
    $destFolder.CopyHere($fontFile.FullName, 0x14)
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
      "Microsoft.WindowsTerminal"
      "Microsoft.PowerShell"
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
      "ajeetdsouza.zoxide"
  )
  # The override parameters make git not add itself to the context menu
  winget install -e --accept-source-agreements --accept-package-agreements --silent Git.Git --override "/VERYSILENT /COMPONENTS="
  foreach ($package in $packages) { winget install -e --accept-source-agreements --accept-package-agreements --silent $package }
  # **** INSTALL NON WINGET STUFF ****
  $fontFolder = DownloadAndDecompress $fontUrl -CreateFolder
  InstallFonts $fontFolder.FullName

  $mingwFolder = DownloadAndDecompress $mingwUrl
  Move-Item -Path $mingwFolder.FullName -Destination $apps
  <# 
    This can't be done directly as some packages, like git, nodejs, and starship will not update $env:Path in the current session, 
    making them not available later on if we set the env right now.
    [Environment]::SetEnvironmentVariable("Path", $env:Path +";$apps\$($mingwFolder.Name)\bin", [EnvironmentVariableTarget]::Machine)
  #>
  $altGrlFolder = DownloadAndDecompress $altGrUrl
  $altGrlFolder = Join-Path $altGrlFolder.FullName "us-inter_amd64.msi"
  Start-Process 'msiexec.exe' -ArgumentList "/i `"$altGrlFolder`" /passive"
}

function SetupDotFiles{
  # Git related stuff
  $gitCmd = "${env:ProgramFiles}/Git/bin/git.exe"
  $dotfiles = "$HOME/.dotfiles/"
  & $gitCmd clone "https://github.com/alanfzf/dotfiles" $dotfiles

  # weird fucking paths
  $wtPath = Get-ChildItem "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_*" | Select-Object -First 1 -Expand FullName
  $wtPath =  "$wtPath/LocalState/"
  $profilePath = Split-Path -Path $PROFILE -Parent
  # small hack if we are on fucking powershell 5
  $profilePath = $profilePath -replace "Windows", ""

  # **** CREATE SYMLINKS ****
  $symLinks = @{
    # realPath = targetPath
    "$env:LOCALAPPDATA/nvim/" = "$dotfiles/.config/nvim/"
    "$env:APPDATA/lazygit/"   = "$dotfiles/.config/lazygit/"
    "$wtPath"                 = "$dotfiles/.config/windows_terminal/"
    "$profilePath"            = "$dotfiles/.config/windows_powershell/"
    "$HOME/starship.toml"     = "$dotfiles/.config/starship.toml"
    "$HOME/.wezterm.lua"      = "$dotfiles/.config/wezterm.lua"
    "$HOME/.ideavimrc"        = "$dotfiles/.ideavimrc"
    "$HOME/.vsvimrc"          = "$dotfiles/.vsvimrc"
    "$HOME/.gitconfig"        = "$dotfiles/.gitconfig"
  }

  foreach ($entry in $symLinks.GetEnumerator()) {
    $symPath = $entry.Key;
    $symTarget = $entry.Value;
    Remove-Item -Path $symPath -Force -Recurse -ErrorAction SilentlyContinue;
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
SetupDotFiles
WindowsTweaks
RemovePrograms
CleanTemp
Stop-Process -ProcessName explorer
