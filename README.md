# RDP-SETUP

## Fresh RDP developer setup

`setup-fresh-rdp.ps1` installs the latest stable Python 3 release through the official Python install manager, plus Node.js LTS (including npm) and Git through WinGet. Run it once on a fresh Windows RDP machine; you can rerun it later to pick up package updates. Python is installed for the account running the script.

1. Open **PowerShell as Administrator** on the RDP machine.
2. From this folder, run `powershell -ExecutionPolicy Bypass -File .\setup-fresh-rdp.ps1`.
3. Open a new PowerShell window and check `python --version`, `node --version`, `npm --version`, and `git --version`.

The script requires WinGet, MSIX/App Installer support, and internet access. On a newly created Windows account, it tries to register WinGet first. If WinGet is unavailable (for example, on some older Windows Server versions), install Microsoft App Installer or use a supported Windows version before rerunning. It does not change the account lockout policy.

## Account lockout script

`disable-account-lockout.bat` sets the **local Windows account lockout threshold to 0**. This allows unlimited failed password attempts without locking local accounts.

## Run

1. Sign in to the target Windows computer with an administrator account.
2. Right-click `disable-account-lockout.bat` and select **Run as administrator**.
3. Check the `net accounts` output displayed by the script.

The script cannot sign in or unlock an account that is already locked. Domain Group Policy can override local settings. Disabling lockout removes a protection against password guessing; use this setting only when it fits your security requirements.

See [Microsoft's account lockout threshold documentation](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/account-lockout-threshold).
