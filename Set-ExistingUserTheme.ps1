<#
.SYNOPSIS
    This script applies the OEM.theme to existing user profiles on a device.
    This is helpful if you've updated your OEM.theme or are applying to to new devices with existing users.
    Run this during a Feature Update task sequence to apply a new theme to existing users without making it mandatory.
    Adds a command to the RunOnce registry key for each user profile on a Windows PC.

.DESCRIPTION
    This script iterates through all user profiles on a Windows PC, loads each user's registry hive,
    and adds a specified command to the RunOnce registry key. The command is prefixed with an exclamation
    point to defer deletion until after execution and runs minimized in a cmd.exe window.
#>

# Define the command to be added
$command = 'cmd.exe /c start /min C:\Users\Default\AppData\Local\Microsoft\Windows\Themes\OEM.theme && timeout /T 5 /nobreak > nul && taskkill /F /IM systemsettings.exe > nul'

# Define the registry path and value name
$regPath = "Software\Microsoft\Windows\CurrentVersion\RunOnce"
$valueName = "!SetOEMTheme"

# Get user profiles
$profiles = Get-ChildItem 'C:\Users' | Where-Object {
    $_.PSIsContainer -and $_.Name -notmatch '^(Default|Public|All Users)$'
}

foreach ($profile in $profiles) {
    # Define the path to the user's NTUSER.DAT file
    $userHive = "$($profile.FullName)\NTUSER.DAT"

    # Skip if NTUSER.DAT doesn't exist
    if (-Not (Test-Path $userHive)) {
        Write-Output "Skipping: $($profile.Name) (No NTUSER.DAT)"
        continue
    }

    try {
        # Load the user hive
        reg load HKU\TempHive "$userHive" 2>$null
        if ($?) {
            # Set RunOnce entry
            Set-ItemProperty -Path "Registry::HKU\TempHive\$regPath" -Name $valueName -Value $command -Type String
            Write-Output "Set RunOnce for $($profile.Name)"
        }
    }
    catch {
        # Output any errors encountered during the process
        Write-Output "Failed for $($profile.Name): $_"
    }
    finally {
        # Unload the user hive
        reg unload HKU\TempHive 2>$null
    }
}
