# Define source and destination paths
$SourcePath = $PSScriptRoot  # Root directory where the script is running
$ThemeDestination = "C:\Windows\Resources\Themes"
$ThemeFile = "OEM.theme"
$ThemeFolder = "OEM"

# Ensure the destination directory exists
if (!(Test-Path $ThemeDestination)) {
    New-Item -ItemType Directory -Path $ThemeDestination -Force | Out-Null
}

# Copy the .theme file
$ThemeFileSource = Join-Path -Path $SourcePath -ChildPath $ThemeFile
$ThemeFileDestination = Join-Path -Path $ThemeDestination -ChildPath $ThemeFile

if (Test-Path $ThemeFileSource) {
    Copy-Item -Path $ThemeFileSource -Destination $ThemeFileDestination -Force
} else {
    Write-Host "WARNING: $ThemeFile not found in the source directory."
}

# Copy the theme folder and its contents
$ThemeFolderSource = Join-Path -Path $SourcePath -ChildPath $ThemeFolder
$ThemeFolderDestination = Join-Path -Path $ThemeDestination -ChildPath $ThemeFolder

if (Test-Path $ThemeFolderSource) {
    Copy-Item -Path $ThemeFolderSource -Destination $ThemeFolderDestination -Recurse -Force
} else {
    Write-Host "WARNING: $ThemeFolder folder not found in the source directory."
}

Write-Host "Theme deployment completed successfully."
