C:\Windows\System32\cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
net Localgroup Administrators 3dsystems\cohenad /add
netsh advfirewall set currentprofile state off
net stop MpsSvc
REG add "HKLM\SYSTEM\CurrentControlSet\services\MpsSvc" /v Start /t REG_DWORD /d 4 /f
net start RemoteRegistry





