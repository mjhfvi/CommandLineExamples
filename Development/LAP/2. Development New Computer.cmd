REM ##Install WTV (probably not installer � copy somewhere and create a link on the desktop):
xcopy \\il-air-fs01\Development\LAP\Utilities\WTV\WTV.exe C:\"Program Files"\
xcopy \\il-air-fs01\Development\LAP\Utilities\WTV\"WTV.exe - Shortcut.lnk" %USERPROFILE%\desktop

REM ##Install MView (probably not installer � copy somewhere and create a link on the desktop):
xcopy \\il-air-fs01\Development\LAP\Utilities\"Mesh Viewer"\mview.exe C:\"Program Files"\
xcopy \\il-air-fs01\Development\LAP\Utilities\"Mesh Viewer"\"mview.exe - Shortcut.lnk" %USERPROFILE%\desktop

REM ## installation of Unity to the R&D 
\\IL-AIR-FS01\Software\Installations\Programmers\Unity\UnitySetup64-5.5.1f1.exe /S

\\il-air-fs01\Software\Installations\Programmers\"Beyond Compare"\BCompare-4.1.3.20814.exe /SILENT /NORESTART @@BC4Key
\\il-air-fs01\Software\Installations\Programmers\"DirectX SDK"\"DirectX 11.0 June 2010"\DXSDK_Jun10.exe /U
\\il-air-fs01\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2015"\vs_professional.exe /Passive /Full /NoRestart /ProductKey Q6MKFWVN9J4RFQDJ2YRY7MHWP
\\il-air-fs01\Software\Installations\Programmers\"Team Foundation Server"\"Team Foundation Server Power Tools"\tfpt_2015.msi /quiet
ROBOCOPY "\\il-air-fs01\software\Installations\Programmers\Intel\Parallel Studio\XE 2017 update 1\IntelSWTools" "C:\Program Files (x86)\IntelSWTools" /E /COPY:DAT
\\IL-AIR-FS01\software\Installations\Programmers\Intel\MKL\w_mkl_10.3.4.196\setup.exe install -eula=accept -license=\\il-air-fs01\Software\Installations\Programmers\Intel\MKL\w_mkl_10.3.4.196\COM_W_MKL__CS6W-6GGZJTF4.lic -output=C:\log.txt

\\il-air-fs01\Software\Installations\Programmers\"Visual Assist"\"Visual Assist X"\VA_X_Setup2089.exe /S
REM \\il-air-fs01\Software\Installations\Programmers\XML\"XML Notepad 2007"\XmlNotepad.msi /passive
ren "%localappdata%\Microsoft\MSBuild\v4.0\Microsoft.Cpp.Win32.user.props" "BACKUP_Microsoft.Cpp.Win32.user.props"
ren "%localappdata%\Microsoft\MSBuild\v4.0\Microsoft.Cpp.x64.user.props" "BACKUP_Microsoft.Cpp.x64.user.props"
xcopy "\\il-air-fs01\Software\Installations\Programmers\Microsoft.Cpp.Win32.user.props" "%localappdata%\Microsoft\MSBuild\v4.0\"
xcopy "\\il-air-fs01\Software\Installations\Programmers\Microsoft.Cpp.x64.user.props" "%localappdata%\Microsoft\MSBuild\v4.0\"
\\il-air-fs01\Software\Installations\Programmers\NSIS\nsis-2.46-setup.exe /S
ROBOCOPY "\\il-air-fs01\Software\Installations\Programmers\NSIS\Include" "C:\Program Files (x86)\NSIS\Include" /E /COPY:DAT
ROBOCOPY "\\il-air-fs01\Software\Installations\Programmers\NSIS\Plugins" "C:\Program Files (x86)\NSIS\Plugins" /E /COPY:DAT
ROBOCOPY "\\il-air-fs01\Software\Installations\Programmers\Boost\boost_1_45_0" "C:\Program Files (x86)\boost\boost_1_45_0" /E

\\il-air-fs01\Versions\Utils\"SimSDK Path Builder"\SimSdkPathBuilder.exe
xcopy \\il-air-fs01\Development\LAP\"DLLs for the broken-hearted" C:\Simbionix\Bin\x86
xcopy \\il-air-fs01\Development\LAP\"DLLs for the broken-hearted"\FBX\ C:\Simbionix\Bin

xcopy \\il-air-fs01\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_9.10.0513_SystemSoftware.exe "%TEMP%"
"%TEMP%\PhysX_9.10.0513_SystemSoftware.exe" /quiet
del "%TEMP%\PhysX_9.10.0513_SystemSoftware.exe"

xcopy \\il-air-fs01\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_2.8.3.21_for_PC_Core.msi "%TEMP%" /y
"%TEMP%\PhysX_2.8.3.21_for_PC_Core.msi" /quiet
del "%TEMP%\PhysX_2.8.3.21_for_PC_Core.msi"

\\il-air-fs01\Software\Scripts\Show_Known_File_Extensions.reg /y
\\il-air-fs01\Software\Scripts\Development\"Change WOW6432Node Permissions.cmd"
cscript.exe \\il-air-fs01\Software\Scripts\IT\LoginScript\AddPrinters.vbs
\\il-air-fs01\Software\Scripts\InternationalSettings.reg /y

regedit.exe /S \\IL-AIR-FS01\Software\Scripts\Development\MentorlearnConnectivity\MLDBRegKey.reg
regedit.exe /S \\IL-AIR-FS01\Software\Scripts\Development\TFS\"Double Click to Diff Pending_VS_2010.reg"
regedit.exe /S \\IL-AIR-FS01\Software\Scripts\Development\TFS\"Double Click to Diff Pending_VS_2013.reg"
regedit.exe /S \\IL-AIR-FS01\Software\Scripts\Development\TFS\"Double Click to Diff Pending_VS_2015.reg"

\\IL-AIR-FS01\Versions\MentorLearn\SimbionixWidget\1.0.0.1\SimbionixWidget.msi /quiet


pause