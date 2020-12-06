\\SERVER\Software\Installations\Programmers\"Team Foundation Server"\"Team Foundation Server Power Tools"\tfpt_2015.msi /qb
\\SERVER\software\Installations\Programmers\Intel\MKL\w_mkl_10.3.4.196\setup.exe install -eula=accept -license=\\SERVER\Software\Installations\Programmers\Intel\MKL\w_mkl_10.3.4.196\COM_W_MKL__CS6W-6GGZJTF4.lic -output=C:\log.txt
ROBOCOPY "\\SERVER\software\Installations\Programmers\Intel\Parallel Studio\XE 2017 update 1\IntelSWTools" "C:\Program Files (x86)\IntelSWTools" /E /COPY:DAT
\\SERVER\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_9.10.0513_SystemSoftware.exe /quiet
\\SERVER\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_2.8.3.21_for_PC_Core.msi /qb
\\SERVER\Software\Installations\Programmers\"Visual Assist"\"Visual Assist X"\VA_X_Setup2089.exe /S
# \\SERVER\Software\Installations\Programmers\XML\"XML Notepad 2007"\XmlNotepad.msi /passive
ren %localappdata%\Microsoft\MSBuild\v4.0\Microsoft.Cpp.Win32.user.props BACKUP_Microsoft.Cpp.Win32.user.props
xcopy \\SERVER\Software\Installations\Programmers\Microsoft.Cpp.Win32.user.props %localappdata%\Microsoft\MSBuild\v4.0\
\\SERVER\Software\Scripts\Development\"Change WOW6432Node Permissions.cmd"
\\SERVER\Software\Installations\Programmers\NSIS\nsis-2.46-setup.exe /S
ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Include" "C:\Program Files (x86)\NSIS\Include" /E /COPY:DAT
ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Plugins" "C:\Program Files (x86)\NSIS\Plugins" /E /COPY:DAT
\\SERVER\Software\Installations\Programmers\Python\python-2.6.4.msi /qb
\\SERVER\Software\Installations\Programmers\Python\python-2.7.12.msi /qb
ROBOCOPY "\\SERVER\Software\Installations\Programmers\Boost\boost_1_45_0" "C:\Program Files (x86)\boost\boost_1_45_0" /E /COPY:DAT
cscript.exe \\SERVER\Software\Scripts\IT\LoginScript\AddPrinters.vbs
\\SERVER\Software\Scripts\InternationalSettings.reg /y
\\SERVER\Software\Scripts\Show_Known_File_Extensions.reg /y
ROBOCOPY "\\SERVER\Software\Installations\UT2004" "c:\UT2004" /E /COPY:DAT

cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\"
set sourceControlRootFolder="C:\SimProjects"

TF.exe workfold $/PROJECT_NAME %sourceControlRootFolder%\PROJECT_NAME 
TF.exe get $/PROJECT_NAME %sourceControlRootFolder%\PROJECT_NAME /recursive /force



regedit.exe /S \\SERVER\Software\Scripts\Development\MentorlearnConnectivity\MLDBRegKey.reg
regedit.exe /S \\SERVER\Software\Scripts\Development\MentorlearnConnectivity\VS_2010.reg
regedit.exe /S \\SERVER\Software\Scripts\Development\MentorlearnConnectivity\VS_2013.reg
regedit.exe /S \\SERVER\Software\Scripts\Development\MentorlearnConnectivity\VS_2015.reg

