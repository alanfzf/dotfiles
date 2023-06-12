$sourceFolder = "$home/win-dot-files"
$destinationFolder = "$home"
$ignoredFiles = @(".gitignore", "README.md") 

$items = Get-ChildItem -Path $sourceFolder 

# delete all symlinks
function RemoveSymLinks{
  Get-ChildItem $destinationFolder -Attributes ReparsePoint | % { $_.Delete() }
}

foreach ($item in $items) {
    $relativePath = $item.FullName.Substring($sourceFolder.Length)
    $linkName = Join-Path -Path $destinationFolder -ChildPath $relativePath
    $targetPath = $item.FullName

    if ($ignoredFiles -notcontains $item.Name){
      New-Item -ItemType SymbolicLink -Path $linkName -Target $targetPath -Force
    }
}
