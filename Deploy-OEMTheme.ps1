# Define destination path
$ThemeDestination = "C:\Windows\Resources\Themes"

# Ensure the destination directory exists
if (!(Test-Path $ThemeDestination)) {
    New-Item -ItemType Directory -Path $ThemeDestination -Force | Out-Null
}

# Copy all .theme files
$ThemeFiles = Get-ChildItem -Path "." -Filter "*.theme" -File
foreach ($ThemeFile in $ThemeFiles) {
    Copy-Item -Path $ThemeFile.FullName -Destination $ThemeDestination -Force
}

# Copy all folders and their contents
$ThemeFolders = Get-ChildItem -Path "." -Directory
foreach ($Folder in $ThemeFolders) {
    Copy-Item -Path $Folder.FullName -Destination $ThemeDestination -Recurse -Force
}

Write-Host "All themes and theme folders have been copied successfully."
