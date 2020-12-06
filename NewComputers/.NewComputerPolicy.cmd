reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall add rule name="Allow from 10.73.31.200" dir=in action=allow protocol=ANY remoteip=10.73.31.200
net start RemoteRegistry
powercfg -x -standby-timeout-ac 0

ipconfig/all > \\10.73.31.200\Downloads\%ComputerName%_%USERNAME%.txt


timeout /t -1







