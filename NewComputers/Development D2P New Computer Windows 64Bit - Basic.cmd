net Localgroup Administrators GROUP /add
\\SERVER\Software\Installations\Programmers\Notepad++\Notepad++7.7.msi /qb
\\SERVER\Software\Installations\Programmers\XML\"XML Notepad 2007"\XmlNotepad.msi /passive

\\SERVER\Software\Installations\Programmers\"Beyond Compare"\BCompare-4.1.3.20814.exe /SILENT /NORESTART @@BC4Key
\\SERVER\Software\Installations\Programmers\"DirectX SDK"\"DirectX 11.0 June 2010"\DXSDK_Jun10.exe /U
\
\\SERVER\Software\Installations\Programmers\NSIS\nsis-3.01-setup.exe /S
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Include" "\\SERVER\Software\Installations\Programmers\NSIS\Include_3.01" /E /COPY:DAT"
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Plugins" "\\SERVER\Software\Installations\Programmers\NSIS\Include_3.01" /E /COPY:DAT"

start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\Boost\boost_1_43_0" "C:\Program Files (x86)\boost\boost_1_43_0" /E /COPY:DAT"
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\Boost\boost_1_45_0" "C:\Program Files (x86)\boost\boost_1_45_0" /E /COPY:DAT"

net use Z: "\\SERVER\Software\Installations\Programmers\Visual Studio\Visual Studio 2017"
Z:\vs_setup.exe --passive --norestart --productKey PFM3DCNM29XFKTB4QJFT8T2DG 

\SERVER\Software\Installations\Programmers\"Visual Assist"\"Visual Assist X"\VA_X_Setup2248_0.exe /S /LU "LICENSE-USER" /LK "LICENSE-KEY"
ren %localappdata%\Microsoft\MSBuild\v4.0\Microsoft.Cpp.Win32.user.props BACKUP_Microsoft.Cpp.Win32.user.props
ren %localappdata%\Microsoft\MSBuild\v4.0\Standard_Microsoft.Cpp.x64.user.props BACKUP_Standard_Microsoft.Cpp.x64.user

xcopy \\SERVER\Software\Installations\Programmers\Microsoft.Cpp.Win32.user.props %localappdata%\Microsoft\MSBuild\v4.0\
xcopy \\SERVER\Software\Installations\Programmers\Microsoft.Cpp.x64.user.props %localappdata%\Microsoft\MSBuild\v4.0\
xcopy D:\SimProjects\PropertyPages\Standard_Microsoft.Cpp.Win32.user.props %APPDATA%\..\Local\Microsoft\MSBuild\Microsoft.Cpp.Win32.user.props
xcopy D:\SimProjects\PropertyPages\Standard_Microsoft.Cpp.x64.user.props %APPDATA%\..\Local\Microsoft\MSBuild\Microsoft.Cpp.x64.user.props

\\SERVER\Software\Installations\Programmers\GitExtensions\Git-2.20.1-64-bit.exe /SILENT /LOADINF="\\SERVER\Software\Scripts\Development\GITUnattendedInstallationParameters.ini"
\\SERVER\Software\Scripts\IT\ElevatePermissions\Elevate11\Elevate64.exe cmd /c "git config --system credential.SERVER.authority Integrated"
\\SERVER\Software\Installations\Programmers\GitForWindows\Utils\git_config_name_and_email_silent.bat

\\SERVER\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_2.8.3.21_for_PC_Core.msi /qb
\\SERVER\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_9.10.0513_SystemSoftware.exe /quiet
\\SERVER\Software\Installations\Programmers\SetACL\64bit\setacl.exe -on "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node" -ot reg -actn ace -ace "n:users;p:full"

\\SERVER\Versions\PROcedure\Insight\ThirdParties\Installer\Prerequisite\"VS2010 redist"\vcredist_2010_x64.exe /q
\\SERVER\Versions\PROcedure\Insight\ThirdParties\Installer\Prerequisite\"VS2013 redist"\vcredist_x64.exe /q
\\SERVER\Versions\PROcedure\Insight\ThirdParties\Installer\Prerequisite\"VS2015 redist"\vcredist_2015_x64.exe /q
\\SERVER\Versions\PROcedure\Insight\ThirdParties\Installer\Prerequisite\"VS2017 redist"\vcredist.2017.exe /q
\\SERVER\Versions\PROcedure\Insight\ThirdParties\Installer\Prerequisite\DotNetFramework\.Net45Sp1.exe /q
\\SERVER\Versions\PROcedure\Insight\ThirdParties\Installer\Prerequisite\"DirectX redist 6.2010"\DXSETUP.exe /silent
\\SERVER\Versions\PROcedure\Insight\ThirdParties\Installer\Prerequisite\Matlab\Matlab.exe setup -mode silent -agreeToLicense yes



timeout /t -1