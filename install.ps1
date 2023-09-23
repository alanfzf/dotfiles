# =====================
# * CONSTANTS *
# =====================
$apps = "C:\Apps"
$temp = "$env:TEMP\files\"
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/jetbrainsmono.zip"
$mingwUrl = "https://github.com/niXman/mingw-builds-binaries/releases/download/13.1.0-rt_v11-rev1/x86_64-13.1.0-release-posix-seh-ucrt-rt_v11-rev1.7z"
$wingetUrl = "https://aka.ms/getwinget"

if(!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
   Write-Host "You must run this script as Administrator!"  -ForegroundColor Red
   Exit
}

if(-not($PSVersionTable.PSVersion.Major -ge 7)){
  $wingetFile = "$temp\winget.msixbundle"
  $dependencies = @(
      "Microsoft.PowerShell"
      "Microsoft.WindowsTerminal"
  )

  Invoke-WebRequest -Uri $wingetUrl -OutFile $wingetFile
  Add-AppxPackage $wingetFile; Remove-Item $wingetFile

  $dependencies | ForEach-Object { winget install -e --accept-source-agreements --accept-package-agreements --silent $_ }

  Write-Host "Installed the required dependencies, but this script requires PowerShell 7 to run!" -ForegroundColor Yellow
  Write-Host "Please re-execute this script again with PowerShell 7" -ForegroundColor Red
  Exit
}


# =====================
# * UTILITY FUNCTIONS *
# =====================
function DownloadAndDecompress {
  param([String]$Url, [Switch]$CreateFolder)

  $fileName = [System.IO.Path]::GetFileName($Url)
  $outFile = Join-Path $temp $fileName
  $outputFolder = $temp

  (New-Object Net.WebClient).DownloadFile($Url, $outFile)

  if($CreateFolder){
    $folderName = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    $outputFolder = Join-Path $outputFolder $folderName
  }
  & "${env:ProgramFiles}\7-Zip\7z.exe" x $outFile "-o$outputFolder" -y | Out-Null

  # return the latest created folder
  return Get-ChildItem -Path $temp -Directory | Sort-Object CreationTime -Descending | Select-Object -First 1
}

function InstallFonts {
  param ([String]$fontFolder)
  $destFolder = (New-Object -ComObject Shell.Application).Namespace(0x14)
  $foundFonts = Get-ChildItem -Path "$fontFolder\*" -Include '*.ttf','*.ttc','*.otf' -Recurse 
  foreach($font in $foundFonts){
    $fontFullName = $font.FullName
    $fontName = $font.Name
    if(Test-Path "C:\Windows\Fonts\$fontName"){ continue }
    $destFolder.CopyHere($fontFullName, 0x10)
  }
}

function CleanTemp {
  Get-ChildItem -Path $temp -Force | ForEach-Object {
    $_ | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
  }
}

# =====================
# * SETUP FUNCTIONS *
# =====================
function InstallPrograms {
  New-Item -ItemType Directory -Path $apps -Force 
  New-Item -ItemType Directory -Path $temp -Force
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
  )
  # The override parameters make git not add itself to the context menu
  winget install -e --accept-source-agreements --accept-package-agreements --silent Git.Git --override "/VERYSILENT /COMPONENTS="
  foreach ($package in $packages) { winget install -e --accept-source-agreements --accept-package-agreements --silent $package }

  # **** INSTALL NON WINGET STUFF ****
  $mingwFolder = DownloadAndDecompress $mingwUrl
  $fontFolder = DownloadAndDecompress $fontUrl -CreateFolder
  Move-Item -Path $mingwFolder.FullName -Destination $apps
  InstallFonts $fontFolder.FullName
  CleanTemp
  [Environment]::SetEnvironmentVariable("Path", $env:Path +";$apps\$($mingwFolder.Name)\bin", [EnvironmentVariableTarget]::Machine)
}

function SetupDotFiles{
  $gitCmd = "${env:ProgramFiles}\Git\bin\git.exe"
  $cfgFolder = "$HOME/dot_files"
  $nvimFolder = "$HOME/AppData/Local/nvim/"
  $ignoredFiles = @(".gitignore", "README.md", "scripts", "install.ps1", "install.sh")

  & $gitCmd clone "https://github.com/alanfvn/dot-files" $cfgFolder 
  & $gitCmd clone "https://github.com/alanfvn/nvim-config" $nvimFolder

  # **** CREATE SYMLINKS ****
  Get-ChildItem -Path $cfgFolder | Where-Object {$_.Name -notin $ignoredFiles } | ForEach-Object {
    $destPath = "$HOME/$($_.Name)"
    $targetPath = $_.FullName
    New-Item -ItemType SymbolicLink -Path $destPath -Target $targetPath -Force
  }

  # **** SET WINDOWS TERMINAL SETTINGS ****
  $wtConfig  = Get-ChildItem "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_*" | Select-Object -First 1 -Expand FullName
  $wtConfig = "$wtConfig\LocalState\settings.json"
  $originalContent = Get-Content -Path $wtConfig -Raw | ConvertFrom-Json
  $newContent = Get-Content -Path "$cfgFolder/.config/windows_terminal/settings.json" -Raw | ConvertFrom-Json

  $newContent.PSObject.Properties | ForEach-Object {
      $propertyName = $_.Name
      $propertyValue = $_.Value

      if ($originalContent.PSObject.Properties[$propertyName]) {
          $originalContent.$propertyName = $propertyValue
      }
      else {
          $originalContent | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue
      }
  }

  $jsonFile = $originalContent | ConvertTo-Json -Depth 10
  $jsonFile | Set-Content -Path $wtConfig

  # **** SET POWERSHELL PROFILE ****
  $pwsProfile = "$cfgFolder/.config/pwsh/profile.ps1"
  $profileFolder = Split-Path -Path $PROFILE -Parent
  New-Item -ItemType Directory -Path $profileFolder -Force
  New-Item -ItemType SymbolicLink -Path $PROFILE -Target $pwsProfile -Force
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
SetupDotFiles
WindowsTweaks
RemovePrograms
Stop-Process -ProcessName explorer
