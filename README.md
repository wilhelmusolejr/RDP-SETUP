# RDP-SETUP

`disable-account-lockout.bat` sets the **local Windows account lockout threshold to 0**. This allows unlimited failed password attempts without locking local accounts.

## Run

1. Sign in to the target Windows computer with an administrator account.
2. Right-click `disable-account-lockout.bat` and select **Run as administrator**.
3. Check the `net accounts` output displayed by the script.

The script cannot sign in or unlock an account that is already locked. Domain Group Policy can override local settings. Disabling lockout removes a protection against password guessing; use this setting only when it fits your security requirements.

See [Microsoft's account lockout threshold documentation](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/account-lockout-threshold).
