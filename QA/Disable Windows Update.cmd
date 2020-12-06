net stop wuauserv
net stop bits
net stop dosvc
sc config wuauserv start= disabled
sc config bits start= disabled
sc config dosvc start= disabled
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 1 /f

