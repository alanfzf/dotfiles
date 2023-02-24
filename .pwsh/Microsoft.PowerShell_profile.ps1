Set-Alias vi nvim

function pyright(){
 New-Item "pyrightconfig.json" -type file -value '{"executionEnvironments": [{"root": "src"}]}'
}

function acenv(){
  .\env\Scripts\activate
}

# PSReadLine
Import-Module PSReadLine
# Set-PSReadLineOption -PredictionSource History
# Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode vi 

$ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
Invoke-Expression (&starship init powershell)
