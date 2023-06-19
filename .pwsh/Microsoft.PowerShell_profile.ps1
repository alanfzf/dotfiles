Set-Alias vi nvim

function rf(){
  Param(
    [Parameter()]
    [string] $path
  )
  if (-not [string]::IsNullOrEmpty($Type)) {
    rm -r -Force $path
  }
}

function la(){
  Param(
    [Parameter()]
    [string] $path
  )
  ls $path -Force
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

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -EditMode emacs
Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function TabCompleteNext

# Starship
$ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
Invoke-Expression (&starship init powershell)
