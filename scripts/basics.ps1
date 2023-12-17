$wingetFile = "./winget.msixbundle"
$wingetUrl = "https://aka.ms/getwinget"
$dependencies = @( 
    "Microsoft.PowerShell" 
    "Microsoft.WindowsTerminal"
)

(New-Object Net.WebClient).DownloadFile($wingetUrl, $wingetFile) 
Add-AppxPackage $wingetFile; Remove-Item $wingetFile
$dependencies | ForEach-Object { winget install -e --accept-source-agreements --accept-package-agreements --silent $_ }
