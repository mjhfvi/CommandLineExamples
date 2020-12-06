net Localgroup Administrators GROUP /add
\\SERVER\Software\Installations\Programmers\Notepad++\npp.7.5.5.installer.x64.msi /qb
\\SERVER\Software\Installations\Programmers\XML\"XML Notepad 2007"\XmlNotepad.msi /passive

\\SERVER\Software\Installations\Programmers\"Beyond Compare"\BCompare-4.1.3.20814.exe /SILENT /NORESTART @@BC4Key
\\SERVER\Software\Installations\Programmers\"DirectX SDK"\"DirectX 11.0 June 2010"\DXSDK_Jun10.exe /U
\\SERVER\Software\Installations\Programmers\Python\python-2.6.4.msi /qb
\\SERVER\Software\Installations\Programmers\Python\python-2.7.12.msi /qb
\\SERVER\Software\Installations\Programmers\NSIS\nsis-3.01-setup.exe /S
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Include" "\\SERVER\Software\Installations\Programmers\NSIS\Include_3.01" /E /COPY:DAT"
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Plugins" "\\SERVER\Software\Installations\Programmers\NSIS\Include_3.01" /E /COPY:DAT"

start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\Boost\boost_1_43_0" "C:\Program Files (x86)\boost\boost_1_43_0" /E /COPY:DAT"
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\Boost\boost_1_45_0" "C:\Program Files (x86)\boost\boost_1_45_0" /E /COPY:DAT"

\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2010"\en_visual_studio_2010_professional_x86_dvd_509727\setup\Setup.exe /Passive /Full /NoRestart
\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2010"\mu_visual_studio_2010_sp1_x86_dvd_651704\Setup.exe /Q /NoRestart

\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2013"\en_visual_studio_professional_2013_with_update_5_x86_dvd_6815752\vs_professional.exe /Passive /Full /NoRestart
\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2015"\vs_professional.exe /AdminFile "\\SERVER\Software\Installations\Programmers\Visual Studio\Visual Studio 2015\VS2015.xml" /Passive /NoRestart /ProductKey LICENSE-KEY
\\SERVER\Software\Installations\Programmers\"Team Foundation Server"\"Team Foundation Server Power Tools"\tfpt_2015.msi /qb

net use Z: "\\SERVER\Software\Installations\Programmers\Visual Studio\Visual Studio 2017"
Z:\SW_DVD5_Visual_Studio_Ent_2017_MultiLang_-2_Lang_Pk_MLF_X21-42637.EXE -p --wait --noWeb --noUpdateInstaller --norestart --productKey PFM3DCNM29XFKTB4QJFT8T2DG --in "\\SERVER\Software\Installations\Programmers\Visual Studio\Visual Studio 2017\InstallWithATL.json"
rem Z:\vs_setup.exe --passive --norestart --productKey PFM3DCNM29XFKTB4QJFT8T2DG 

\\SERVER\software\Installations\Programmers\Intel\MKL\w_mkl_10.3.4.196\setup.exe install -eula=accept -license=\\SERVER\Software\Installations\Programmers\Intel\MKL\w_mkl_10.3.4.196\COM_W_MKL__CS6W-6GGZJTF4.lic -output=C:\log.txt
start cmd /k "ROBOCOPY "\\SERVER\software\Installations\Programmers\Intel\Parallel Studio\XE 2017 update 1\IntelSWTools" "C:\Program Files (x86)\IntelSWTools" /E /COPY:DAT"
\\SERVER\Software\Installations\Programmers\"Visual Assist"\"Visual Assist X"\VA_X_Setup2248_0.exe /S /LU "LICENSE-USER" /LK "LICENSE-KEY"
ren %localappdata%\Microsoft\MSBuild\v4.0\Microsoft.Cpp.Win32.user.props BACKUP_Microsoft.Cpp.Win32.user.props
ren %localappdata%\Microsoft\MSBuild\v4.0\Standard_Microsoft.Cpp.x64.user.props BACKUP_Standard_Microsoft.Cpp.x64.user

xcopy \\SERVER\Software\Installations\Programmers\Microsoft.Cpp.Win32.user.props %localappdata%\Microsoft\MSBuild\v4.0\
xcopy \\SERVER\Software\Installations\Programmers\Microsoft.Cpp.x64.user.props %localappdata%\Microsoft\MSBuild\v4.0\
xcopy D:\SimProjects\PropertyPages\Standard_Microsoft.Cpp.Win32.user.props %APPDATA%\..\Local\Microsoft\MSBuild\Microsoft.Cpp.Win32.user.props
xcopy D:\SimProjects\PropertyPages\Standard_Microsoft.Cpp.x64.user.props %APPDATA%\..\Local\Microsoft\MSBuild\Microsoft.Cpp.x64.user.props

\\SERVER\Software\Installations\Programmers\GitExtensions\Git-2.20.1-64-bit.exe /SILENT /LOADINF="\\SERVER\Software\Scripts\Development\GITUnattendedInstallationParameters.ini"
\\SERVER\Software\Scripts\IT\ElevatePermissions\Elevate11\Elevate64.exe cmd /c "git config --system credential.il-air-dev01.authority Integrated"
\\SERVER\Software\Scripts\IT\ElevatePermissions\Elevate11\Elevate64.exe cmd /c "\\SERVER\Software\Installations\Programmers\GitForWindows\Utils\git_config_name_and_email_silent.bat"

\\SERVER\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_2.8.3.21_for_PC_Core.msi /qb
\\SERVER\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_9.10.0513_SystemSoftware.exe /quiet
\\SERVER\Software\Installations\Programmers\SetACL\64bit\setacl.exe -on "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node" -ot reg -actn ace -ace "n:users;p:full"


timeout /t -1