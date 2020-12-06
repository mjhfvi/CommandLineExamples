\\SERVER\Software\Installations\Java\"Oracle E-Business Suite"\jre-8u191-windows-x64.exe /s
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\New Windows" /v "PopupMgr" /t REG_SZ /d yes /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\New Windows" /v "Use Anchor Hover Color" /t REG_SZ /d 1 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\New Windows" /v "UseSecBand" /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\New Windows" /v "PlaySound" /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\New Windows" /v "BlockUserInit" /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\New Windows" /v "UseTimerMethod" /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\New Windows" /v "UseHooks" /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\New Windows" /v "AllowHTTPS" /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\New Windows" /v "BlockControls" /t REG_DWORD /d 0 /f

REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\New Windows\Allow" /v "3dsystems.kronos.net" /t REG_BINARY /d 00000002 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\New Windows\Allow" /v "oracle.3dsystems.com" /t REG_BINARY /d 00000002 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\New Windows\Allow" /v "qsoft.quickparts.com" /t REG_BINARY /d 00000002 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\New Windows\Allow" /v "oracleprodr12.3dsystems.com" /t REG_BINARY /d 00000002 /f


REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d "https://oracleprodr12.3dsystems.com" /f

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy" /v "EnableAutoUpdateCheck" /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy" /v "EnableJavaUpdate" /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy" /v "NotifyDownload" /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy" /v "NotifyInstall" /t REG_DWORD /d 0 /f

REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /v "UserFilter" /t REG_BINARY /d "411f00005308adba010000003800000001000000010000000c00000091dcadf287bfd201010000000d0033006400730079007300740065006d0073002e0063006f006d00"  /f

