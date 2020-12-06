net Localgroup Administrators GROUP /add
dism /online /add-package /packagepath:\\SERVER\Software\Drivers\microsoft-windows-netfx3-ondemand-package.cab

\\SERVER\Software\Installations\Programmers\Notepad++\npp.6.8.8.Installer.exe /S
\\SERVER\Software\Installations\Programmers\XML\"XML Notepad 2007"\XmlNotepad.msi /passive

\\SERVER\Software\Installations\Programmers\"Beyond Compare"\BCompare-4.1.3.20814.exe /SILENT /NORESTART @@BC4Key
\\SERVER\Software\Installations\Programmers\"DirectX SDK"\"DirectX 11.0 June 2010"\DXSDK_Jun10.exe /U
\\SERVER\Software\Installations\Programmers\Python\python-2.6.4.msi /qb
\\SERVER\Software\Installations\Programmers\Python\python-2.7.12.msi /qb
\\SERVER\Software\Installations\Programmers\NSIS\nsis-2.46-setup.exe /S
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Include" "C:\Program Files (x86)\NSIS\Include" /E /COPY:DAT"
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Plugins" "C:\Program Files (x86)\NSIS\Plugins" /E /COPY:DAT"

start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\Boost\boost_1_45_0" "C:\Program Files (x86)\boost\boost_1_45_0" /E /COPY:DAT"
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\UT2004" "c:\UT2004" /E /COPY:DAT"
netsh advfirewall firewall add rule name="UT2004 tcp" dir=out action=allow protocol=TCP localport=7777-7788
netsh advfirewall firewall add rule name="UT2004 udp" dir=out action=allow protocol=UDP localport=7777-7788
\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2010"\en_visual_studio_2010_professional_x86_dvd_509727\setup\Setup.exe /Passive /Full /NoRestart
\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2010"\mu_visual_studio_2010_sp1_x86_dvd_651704\Setup.exe /Q /NoRestart

\\SERVER\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_2.8.3.21_for_PC_Core.msi /qb
\\SERVER\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_9.10.0513_SystemSoftware.exe /quiet
\\SERVER\Software\Installations\Programmers\SetACL\64bit\setacl.exe -on "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node" -ot reg -actn ace -ace "n:users;p:full"

\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2013"\en_visual_studio_professional_2013_with_update_5_x86_dvd_6815752\vs_professional.exe /Passive /Full /NoRestart
\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2015"\vs_professional.exe /AdminFile "\\SERVER\Software\Installations\Programmers\Visual Studio\Visual Studio 2015\VS2015.xml" /Passive /NoRestart /ProductKey LICENSE-KEY
\\SERVER\Software\Installations\Programmers\"Team Foundation Server"\"Team Foundation Server Power Tools"\tfpt_2015.msi /qb

\\SERVER\software\Installations\Programmers\Intel\MKL\w_mkl_10.3.4.196\setup.exe install -eula=accept -license=\\SERVER\Software\Installations\Programmers\Intel\MKL\w_mkl_10.3.4.196\COM_W_MKL__CS6W-6GGZJTF4.lic -output=C:\log.txt
start cmd /k "ROBOCOPY "\\SERVER\software\Installations\Programmers\Intel\Parallel Studio\XE 2017 update 1\IntelSWTools" "C:\Program Files (x86)\IntelSWTools" /E /COPY:DAT"
\\SERVER\Software\Installations\Programmers\"Visual Assist"\"Visual Assist X"\VA_X_Setup2089.exe /S
ren %localappdata%\Microsoft\MSBuild\v4.0\Microsoft.Cpp.Win32.user.props BACKUP_Microsoft.Cpp.Win32.user.props
start cmd /k "xcopy \\SERVER\Software\Installations\Programmers\Microsoft.Cpp.Win32.user.props %localappdata%\Microsoft\MSBuild\v4.0\"

\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2008"\en_visual_studio_2008_professional_x86_dvd_x14-26326\setup.exe
\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2008"\VS2008TeamExplorer\Setup.exe
\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2008"\VS2008SP1ENUX1512962\vs90sp1\SPInstaller.exe
\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2008"\VS90SP1-KB974558-x86.exe



timeout /t -1