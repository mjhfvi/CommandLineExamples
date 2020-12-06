REG load "HKU\Default" "C:\Users\Default\NTUSER.DAT"
REG add "HKEY_USERS\default\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /V "InstallScript" /t REG_SZ /F /D "\\IL-AIR-FS01\Software\Scripts\NewComputers\DevelopmentUserEnvironmentForDevelopers.cmd"
REG unload "HKU\Default"