dism /online /add-package /packagepath:\\SERVER\Software\Drivers\microsoft-windows-netfx3-ondemand-package.cab
\\SERVER\Software\Scripts\Show_Known_File_Extensions.reg /y
\\SERVER\Software\Installations\7zip\7z1900-x64.msi /qb
\\SERVER\Software\Installations\Programmers\Notepad++\npp.6.8.8.Installer.exe /S
\\SERVER\Software\Installations\Programmers\XML\"XML Notepad 2007"\XmlNotepad.msi /passive
\\SERVER\Software\Installations\Programmers\"DirectX SDK"\"DirectX 11.0 June 2010"\DXSDK_Jun10.exe /U
\\SERVER\Software\Installations\Programmers\Python\python-2.6.4.msi /qb
\\SERVER\Software\Installations\Programmers\Python\python-2.7.12.msi /qb
\\SERVER\Software\Installations\Programmers\NSIS\nsis-2.46-setup.exe /S
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Include" "C:\Program Files (x86)\NSIS\Include" /E /COPY:DAT"
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Plugins" "C:\Program Files (x86)\NSIS\Plugins" /E /COPY:DAT"

start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\Boost\boost_1_45_0" "C:\Program Files (x86)\boost\boost_1_45_0" /E /COPY:DAT"
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

start cmd /k "ROBOCOPY "\\SERVER\Software\Scripts\Development\TFS\Team Foundation" "C:\Users\%username%\AppData\Local\Microsoft\Team Foundation" /E /COPY:DAT"
regedit.exe /S \\SERVER\Software\Scripts\Development\TFS\AddTeamProjectServer.reg

cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\"
c:
\\SERVER\Versions\Utils\"SimSDK Path Builder"\SimSdkPathBuilder.exe

start cmd /k xcopy \\SERVER\Development\LAP\"DLLs for the broken-hearted"\ C:\Simbionix\Bin\x86
start cmd /k xcopy \\SERVER\Development\LAP\"DLLs for the broken-hearted"\FBX\ C:\Simbionix\Bin

timeout /t -1

