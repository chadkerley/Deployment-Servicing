# Deployment Servicing

## Overview

This repository contains PowerShell scripts and other resources used for Windows deployment servicing via Microsoft Intune and ConfigMgr (SCCM). These scripts help automate and streamline various deployment tasks, including customizing Windows themes, configuring system settings, and automating post-deployment servicing.

## Contents

- **Theme Deployment Script** ([`Deploy-OEMTheme.ps1`](./Deploy-OEMTheme.ps1))
  - Copies a custom `.theme` file and its associated folder to `C:\Windows\Resources\Themes`.
  - Designed to run as a **Run PowerShell Script** step in an **OSD Task Sequence**.
- **Additional Deployment Scripts**
  - More scripts will be added to handle various deployment and servicing tasks.

## Usage

1. **SCCM Task Sequence (OSD):**
   - Package the script and required files into an SCCM deployment package.
   - Add a **Run PowerShell Script** step in the task sequence.
   - Reference the package and set execution policy to `Bypass`.
2. **Intune Deployment:**
   - Package the script into a **Win32 App** using `IntuneWinAppUtil`.
   - Deploy via Intune as a required or available app.

## Contributing

Contributions are welcome! If you have useful scripts or improvements, feel free to submit a pull request.

## License

This repository is licensed under the MIT License. See `LICENSE` for more details.

