reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall add rule name="Allow from 10.73.2.200" dir=in action=allow protocol=ANY remoteip=10.73.2.200
net Localgroup Administrators 3dsystems\user /add
net start RemoteRegistry
powercfg �x -standby-timeout-ac 0

ipconfig/all > \\REMOTE-COMPUTER\Downloads\%ComputerName%_%USERNAME%.txt




