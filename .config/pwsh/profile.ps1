Set-Alias vi nvim
Set-Alias python py
Set-Alias lg lazygit
Set-Alias shutdown Stop-Computer
Set-Alias cat bat
Set-Alias ls eza
Remove-Alias sl -Force

function Rf(){
  Param(
    [Parameter()]
    [string] $Path
  )
  if (-not [string]::IsNullOrEmpty($Path)) {
    Remove-Item -r -Force $Path
  }
}

function Pth(){
  param(
      [Parameter()]
      [String]$File
  )
  if (Test-Path -Path $File) {
    $item = Get-Item -Path $File
    Write-Host "Copying path $($item.FullName)"
    $item.FullName | Set-Clipboard
  }
}


function NewTsProject(){
  npm init -y
  # dependencies
  npm install typescript --save-dev
  npm install @types/node --save-dev
  npm install --save-dev ts-node nodemon
  npm install --save-dev rimraf
  # scripts
  npm pkg set scripts.build="rimraf ./build && tsc"
  npm pkg set scripts.dev="npx nodemon"
  npm pkg set scripts.start="npm run build && node build/index.js"
  # other config
  npx tsc --init --rootDir src --outDir build --esModuleInterop --resolveJsonModule --lib es6 --module commonjs --allowJs true --noImplicitAny true
  New-Item "nodemon.json" -type file -value '{"watch": ["src"],"ext": ".ts,.js","ignore": [],"exec": "npx ts-node ./src/index.ts"}'
  mkdir src
}

function PyRight(){
 New-Item "pyrightconfig.json" -type file -value '{"executionEnvironments": [{"root": "src"}]}'
}

function AcEnv(){
  $script = fd -I activate.ps1 -1;
  & $script
}

function Gs {
  git status
}

function Sed($file, $find, $replace) {
  (Get-Content $file).replace("$find", $replace) | Set-Content $file
}

function Which($name) {
  Get-Command $name | Select-Object -ExpandProperty Definition
}

function Touch($file) {
  if (-not (Test-Path -Path $file)){
    "" | Out-File $file -Encoding ASCII
  }
}

function Ex {
  param(
      [Parameter()]
      [String]$dir = '.'
  )
  explorer $dir
}

function Sudo {
  Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command &{Set-Location $PWD}"
}


function Invoke-Starship-PreCommand {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $prompt = "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem"){
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $host.ui.Write($prompt)
}


# PSReadLine
Import-Module PSReadLine
Import-Module Z
Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function TabCompleteNext

# Starship
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
Invoke-Expression (&starship init powershell)
