netsh advfirewall set currentprofile state off
net stop MpsSvc
REG add "HKLM\SYSTEM\CurrentControlSet\services\MpsSvc" /v Start /t REG_DWORD /d 4 /f
