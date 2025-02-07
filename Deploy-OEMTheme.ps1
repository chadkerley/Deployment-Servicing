# Define destination paths
$DefaultThemeDestination = "C:\Users\Default\AppData\Local\Microsoft\Windows\Themes"
$SystemThemeDestination = "C:\Windows\Resources\Themes"

# Ensure destination directories exist
foreach ($Path in $DefaultThemeDestination, $SystemThemeDestination) {
    if (!(Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

# Copy OEM.theme to the Default User's Theme Directory
$OEMTheme = Get-ChildItem -Path "." -Filter "OEM.theme" -File
if ($OEMTheme) {
    Copy-Item -Path $OEMTheme.FullName -Destination $DefaultThemeDestination -Force
}

# Copy all other .theme files to the System Theme Directory
$OtherThemeFiles = Get-ChildItem -Path "." -Filter "*.theme" -File | Where-Object { $_.Name -ne "OEM.theme" }
foreach ($ThemeFile in $OtherThemeFiles) {
    Copy-Item -Path $ThemeFile.FullName -Destination $SystemThemeDestination -Force
}

# Copy all theme folders and their contents to the System Theme Directory
$ThemeFolders = Get-ChildItem -Path "." -Directory
foreach ($Folder in $ThemeFolders) {
    Copy-Item -Path $Folder.FullName -Destination $SystemThemeDestination -Recurse -Force
}
