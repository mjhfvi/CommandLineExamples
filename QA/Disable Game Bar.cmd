REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR /f /v AppCaptureEnabled /t REG_DWORD /d 0
REG ADD HKEY_CURRENT_USER\System\GameConfigStore /f /v GameDVR_Enabled /t REG_DWORD /d 0
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR /f /v HistoricalCaptureEnabled /t REG_DWORD /d 0
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR /f /v AllowgameDVR /t REG_DWORD /d 0


