Set-Alias vi nvim
Set-Alias python py
Set-Alias lg lazygit
Set-Alias shutdown Stop-Computer
Remove-Alias sl -Force

function rf(){
  Param(
    [Parameter()]
    [string] $Path
  )
  if (-not [string]::IsNullOrEmpty($Path)) {
    Remove-Item -r -Force $Path
  }
}


function ll(){
  Param(
    [Parameter()]
    [string] $Path
  )
  Get-ChildItem $Path -Force
}

function pth(){
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
  .\env\Scripts\activate
}

function SilentAudio(){
  ffmpeg -f lavfi -i anullsrc=r=11025:cl=mono -t 5 -acodec mp3 out.mp3
}

function Gs {
  git status
}

function Top(){
  While(1) {
    Get-Process | Sort-Object -des cpu | Select-Object -f 15 | 
    Format-Table -a; Start-Sleep 1; Clear-Host
  }
}

function Sed($file, $find, $replace) {
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}

function Which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function Touch($file) {
    "" | Out-File $file -Encoding ASCII
}

function Grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function Ex {

  param(
      [Parameter()]
      [String]$dir = '.'
  )

  explorer $dir
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
