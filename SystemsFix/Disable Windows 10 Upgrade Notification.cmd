REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v DisableGWX /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableOSUpgrade /d 1 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v AllowOSUpgrade /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v ReservationsAllowed /d 0 /f
TASKKILL /IM GWX.exe /T /F 

start /wait wusa /uninstall /kb:3035583 /quiet /norestart /log
start /wait wusa /uninstall /kb:3035583 /quiet /norestart /log
exit