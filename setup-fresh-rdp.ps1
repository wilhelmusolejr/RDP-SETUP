# Run once on a fresh Windows RDP machine from an elevated PowerShell window.
$ErrorActionPreference = 'Stop'

Write-Host 'Fresh RDP setup: installing Python, Node.js LTS, and Git.'
Write-Host 'Run this again later to check for available package updates.'

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'Open PowerShell as Administrator, then run this script again.'
}

if (-not (Get-Command winget.exe -ErrorAction SilentlyContinue)) {
    # WinGet can be present but not registered for a newly created Windows user.
    try {
        Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe -ErrorAction Stop
    } catch {
        Write-Warning "Could not register WinGet: $_"
    }
}

if (-not (Get-Command winget.exe -ErrorAction SilentlyContinue)) {
    throw 'WinGet is unavailable. Install Microsoft App Installer (or use Windows Server 2025 / a supported Windows desktop), then rerun this script.'
}

if (-not (Get-Command pymanager.exe -ErrorAction SilentlyContinue)) {
    Write-Host 'Installing the official Python install manager...'
    Add-AppxPackage -AppInstallerFile 'https://www.python.org/ftp/python/pymanager/pymanager.appinstaller'
}
if (-not (Get-Command pymanager.exe -ErrorAction SilentlyContinue)) {
    throw 'Python install manager is unavailable. Check that this Windows version supports MSIX/App Installer, then rerun the script.'
}

Write-Host 'Installing the latest stable Python release...'
& pymanager.exe install --update default
if ($LASTEXITCODE -ne 0) {
    throw "Python installation failed (exit code $LASTEXITCODE)."
}

$packages = @(
    @{ Name = 'Node.js LTS'; Id = 'OpenJS.NodeJS.LTS' }
    @{ Name = 'Git'; Id = 'Git.Git' }
)

$failed = @()
foreach ($package in $packages) {
    Write-Host "Installing or updating $($package.Name) ($($package.Id))..."
    & winget.exe install --id $package.Id --exact --source winget --silent --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "$($package.Name) failed (WinGet exit code $LASTEXITCODE)."
        $failed += $package.Name
    }
}

if ($failed.Count -gt 0) {
    throw "Setup incomplete. Check the WinGet output above, then rerun this script. Failed: $($failed -join ', ')"
}

Write-Host 'Setup finished. Open a NEW PowerShell window so PATH updates are loaded.'
Write-Host 'Then verify with: python --version; node --version; npm --version; git --version'
