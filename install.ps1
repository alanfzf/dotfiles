if(!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # NOTE: i am aware of '#Requires -RunAsAdministrator' instruction, but it does not work with Invoke Web Request.
    throw "You must run this script as Administrator!"
}

# =====================
# * MODULES *
# =====================
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name Fonts
Import-Module -Name Fonts

# =====================
# * CONSTANTS *
# =====================
$temp = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath ([System.IO.Path]::GetRandomFileName())
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/jetbrainsmono.zip"
$altGrUrl = "https://github.com/thomasfaingnaert/win-us-intl-altgr/releases/download/v1.0/us-inter.zip"

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
        $outFolder = $temp
    }

    return Get-ChildItem -Path $outFolder -Directory | Sort-Object CreationTime -Descending | Select-Object -First 1
}

function CleanTemp {
    Remove-Item -Recurse -Force $temp
    Stop-Process -ProcessName explorer
}

# =====================
# * SETUP FUNCTIONS *
# =====================
function InstallPrograms {
    # **** INSTALL WINGET PACKAGES ****
    $Packages = @(
        "7zip.7zip"
        "Discord.Discord"
        "VideoLAN.VLC"
        "Microsoft.PowerToys"
        "Microsoft.WindowsTerminal"
    )

    foreach ($package in $packages) {
        winget install -e --accept-source-agreements --accept-package-agreements --silent $package
    }

    ## ====== [ font installation ] ======
    $fontFolder = DownloadAndDecompress $fontUrl -CreateFolder
    Get-ChildItem $fontFolder.FullName | Where-Object { $_.Extension -in @(".otf", ".ttf")  } | ForEach-Object {
        Install-Font -Path $_.FullName
    }

    ## ====== [ alt-gr keyboard layout ] ======
    $altGrlFolder = DownloadAndDecompress $altGrUrl
    $altGrlFolder = Join-Path $altGrlFolder.FullName "us-inter_amd64.msi"
    Start-Process 'msiexec.exe' -ArgumentList "/i `"$altGrlFolder`" /passive"
}

function WindowsTweaks {
    $RegPathCM        = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
    $RegPathEx        = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
    $RegPathTheme     = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    $RegPathExCurrent = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
    $RegPathDate      = "HKCU:\Control Panel\International"

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
    Set-ItemProperty -Path $RegPathDate -Name sShortDate -Value "yyyy-MM-dd"
    Set-ItemProperty -Path $RegPathDate -Name sShortTime -Value "HH:mm"
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
WindowsTweaks
RemovePrograms
CleanTemp
