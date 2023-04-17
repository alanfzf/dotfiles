Set-Alias vi nvim

function new_ts_project(){
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

function pyright(){
 New-Item "pyrightconfig.json" -type file -value '{"executionEnvironments": [{"root": "src"}]}'
}

function acenv(){
  .\env\Scripts\activate
}

function silent_audio(){
  ffmpeg -f lavfi -i anullsrc=r=11025:cl=mono -t 5 -acodec mp3 out.mp3
}

function pdoc(){
  Param
  (
   [Parameter(Mandatory=$true, Position=0)]
   [string] $file
  )
  pandoc $file --wrap=preserve -f markdown-implicit_figures+hard_line_breaks --lua-filter "$home\obsidian-callouts.lua" -o "$home\Desktop\$file.pdf"
  # pandoc $file --wrap=preserve -f markdown-implicit_figures+hard_line_breaks+yaml_metadata_block -o "$home\Desktop\$file.pdf"
}

function gen_docs(){
  $files = Get-ChildItem -Filter *.md -File -Name -Path .
  foreach ($file in $files){
    pdoc $file
    Write-Host "Done exporting: $file"
  }
}



Import-Module PSReadLine
Set-PSReadLineOption -EditMode vi 
$ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
Invoke-Expression (&starship init powershell)
