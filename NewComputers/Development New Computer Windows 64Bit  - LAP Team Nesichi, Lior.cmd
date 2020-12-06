net Localgroup Administrators GROUP /add
xcopy \\IL-AIR-FS01\Software\Installations\3DIT c:\3DIT\ /y
# \\il-air-fs01\Software\Installations\7zip\7z920-x64.msi /qb
#\\il-air-fs01\Software\Installations\Adobe\"Adobe Acrobat"\AcroRdrDC1501020056_en_US.exe /sAll
\\il-air-fs01\Software\Installations\GoogleApps\googlechromestandaloneenterprise64.msi /qb
\\il-air-fs01\Software\Installations\"Firefox Setup 44.0.2.exe" /s
\\il-air-fs01\Software\Installations\Java\jre-8u73-windows-x64.exe /s
# \\il-air-fs01\Software\Installations\Programmers\Notepad++\npp.6.8.8.Installer.exe /S
#\\IL-AIR-FS01\Software\Installations\Jabber\CiscoJabberSetup.msi /qb
#\\il-air-fs01\Software\Installations\Microsoft\OfficeAllVersions\Office2016\SW_DVD5_Office_Professional_Plus_2016_64Bit_English_MLF_X20-42432\setup  /adminfile \\il-air-fs01\Software\Installations\Microsoft\OfficeAllVersions\Office2016\SW_DVD5_Office_Professional_Plus_2016_64Bit_English_MLF_X20-42432\unattended.MSP
#\\IL-AIR-FS01\Software\Installations\FireAmp\3D_Clients_FireAMPSetup.exe /S
\\il-air-fs01\Software\Installations\Programmers\"Beyond Compare"\BCompare-4.1.3.20814.exe /SILENT /NORESTART @@BC4Key
#dism /online /add-package /packagepath:\\il-air-fs01\Software\Drivers\microsoft-windows-netfx3-ondemand-package.cab
\\il-air-fs01\Software\Installations\Programmers\"DirectX SDK"\"DirectX 11.0 June 2010"\DXSDK_Jun10.exe /U
\\il-air-fs01\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2010"\en_visual_studio_2010_professional_x86_dvd_509727\setup\Setup.exe /Passive /Full /NoRestart
\\il-air-fs01\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2010"\mu_visual_studio_2010_sp1_x86_dvd_651704\Setup.exe /Q /NoRestart
#\\il-air-fs01\Software\Installations\Programmers\"Team Explorer"\tfpt.msi /qb
\\il-air-fs01\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2013"\en_visual_studio_professional_2013_with_update_5_x86_dvd_6815752\vs_professional.exe /Passive /Full /NoRestart
\\il-air-fs01\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2015"\vs_professional.exe /Passive /Full /NoRestart /ProductKey LICENSE-KEY
\\il-air-fs01\Software\Installations\Programmers\"Team Foundation Server"\"Team Foundation Server Power Tools"\tfpt_2015.msi /qb
\\IL-AIR-FS01\software\Installations\Programmers\Intel\MKL\w_mkl_10.3.4.196\setup.exe install -eula=accept -license=\\il-air-fs01\Software\Installations\Programmers\Intel\MKL\w_mkl_10.3.4.196\COM_W_MKL__CS6W-6GGZJTF4.lic -output=C:\log.txt
ROBOCOPY "\\il-air-fs01\software\Installations\Programmers\Intel\Parallel Studio\XE 2017 update 1\IntelSWTools" "C:\Program Files (x86)\IntelSWTools" /E /COPY:DAT
\\il-air-fs01\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_9.10.0513_SystemSoftware.exe /quiet
\\il-air-fs01\Software\Installations\Programmers\NVidia\"PhysX SDK"\PhysX_2.8.3.21_for_PC_Core.msi /qb
\\il-air-fs01\Software\Installations\Programmers\"Visual Assist"\"Visual Assist X"\VA_X_Setup2089.exe /S
# \\il-air-fs01\Software\Installations\Programmers\XML\"XML Notepad 2007"\XmlNotepad.msi /passive
ren %localappdata%\Microsoft\MSBuild\v4.0\Microsoft.Cpp.Win32.user.props BACKUP_Microsoft.Cpp.Win32.user.props
xcopy \\il-air-fs01\Software\Installations\Programmers\Microsoft.Cpp.Win32.user.props %localappdata%\Microsoft\MSBuild\v4.0\
\\il-air-fs01\Software\Scripts\Development\"Change WOW6432Node Permissions.cmd"
\\il-air-fs01\Software\Installations\Programmers\NSIS\nsis-2.46-setup.exe /S
ROBOCOPY "\\il-air-fs01\Software\Installations\Programmers\NSIS\Include" "C:\Program Files (x86)\NSIS\Include" /E /COPY:DAT
ROBOCOPY "\\il-air-fs01\Software\Installations\Programmers\NSIS\Plugins" "C:\Program Files (x86)\NSIS\Plugins" /E /COPY:DAT
\\il-air-fs01\Software\Installations\Programmers\Python\python-2.6.4.msi /qb
\\il-air-fs01\Software\Installations\Programmers\Python\python-2.7.12.msi /qb
ROBOCOPY "\\il-air-fs01\Software\Installations\Programmers\Boost\boost_1_45_0" "C:\Program Files (x86)\boost\boost_1_45_0" /E /COPY:DAT
cscript.exe \\il-air-fs01\Software\Scripts\IT\LoginScript\AddPrinters.vbs
\\il-air-fs01\Software\Scripts\InternationalSettings.reg /y
\\il-air-fs01\Software\Scripts\Show_Known_File_Extensions.reg /y
ROBOCOPY "\\il-air-fs01\Software\Installations\UT2004" "c:\UT2004" /E /COPY:DAT

cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\"
C:
tf workspace /new /s:http://il-air-dev01:8080/tfs/DefaultCollection /noprompt
tf workfold "$/" "D:\SimProjects" /map /collection:http://il-air-dev01:8080/tfs/DefaultCollection /workspace:%computername%

cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\"
c:
TF.exe get $/BasicStuff C:\SimProjects\Main\BasicStuff /recursive /force
TF.exe get $/FlashDX C:\SimProjects\Main\FlashDX /recursive /force
TF.exe get $/GPGPU C:\SimProjects\Main\GPGPU /recursive /force
TF.exe get $/Hardware C:\SimProjects\Main\Hardware /recursive /force
TF.exe get $/"LAP hardware installation" C:\SimProjects\Main\HW configuration /recursive /force
TF.exe get $/PropertyPages C:\SimProjects\Main\PropertyPages /recursive /force
TF.exe get $/RenderContexts C:\SimProjects\Main\RenderContexts /recursive /force
TF.exe get $/Renderer_DX9 C:\SimProjects\Main\Renderer_DX9 /all /force
TF.exe get $/SimDynamicExtensions C:\SimProjects\Main\SimDynamicExtensions /recursive /force
TF.exe get $/SimEngCommon C:\SimProjects\Main\SimEngCommon /recursive /force
TF.exe get $/Sim-Engine C:\SimProjects\Main\Sim-Engine /recursive /force
TF.exe get $/TargetsManager C:\SimProjects\Main\TargetsManager /recursive /force
TF.exe get $/UltraSound_Lib C:\SimProjects\Main\UltraSound_Lib /recursive /force


TF.exe get $/Appendectomy/2_0_0_0_with_patches D:\SimProjects\Lap\Appendectomy  /recursive /force
TF.exe get $/DaVince_Branch/Cases/CuffClosureLAP D:\SimProjects\Lap\"LAP Cuff Closure"\Module0010  /recursive /force
TF.exe get $/"LAP Cuff Closure" D:\SimProjects\Lap\"LAP Cuff Closure"\  /recursive /force
TF.exe get $/Gastric D:\SimProjects\Lap\"SimEngine Gastric"\  /recursive /force
TF.exe get $/Hysterectomy/New_Solution D:\SimProjects\Lap\Hysterectomy\New_Solution  /recursive /force
TF.exe get $/"LAP Cholangiogram" D:\SimProjects\Lap\"LAP Cholangiogram"\  /recursive /force
TF.exe get $/"LAP Chole" D:\SimProjects\Lap\"SimEngine LapChole"\  /recursive /force
TF.exe get $/"LAP Legacy Projects" D:\SimProjects\Lap\"LAP Legacy Projects"\  /recursive /force
TF.exe get $/Nephrectomy D:\SimProjects\Lap\"SimEngine Neph"\  /recursive /force
TF.exe get $/"Sim-Engine Gyn" D:\SimProjects\Lap\"SimEngine Gyn"\  /recursive /force
TF.exe get $/SimEngine_LET D:\SimProjects\Lap\"SimEngine LET"\  /recursive /force
TF.exe get $/SimEngine_Sig D:\SimProjects\Lap\"SimEngine Sig"\  /recursive /force
TF.exe get $/SuturingLapVS2010 D:\SimProjects\Lap\"SimEngine Suturing"\  /recursive /force
TF.exe get $/"Ventral Hernia" D:\SimProjects\Lap\"SimEngine Hernia"\  /recursive /force


\\il-air-fs01\Versions\Utils\"SimSDK Path Builder"\SimSdkPathBuilder.exe


xcopy \\il-air-fs01\Development\LAP\"DLLs for the broken-hearted"\ C:\Simbionix\Bin\x86
xcopy \\il-air-fs01\Development\LAP\"DLLs for the broken-hearted"\FBX\ C:\Simbionix\Bin

D:\SimProjects\Sim-Engine\SMB_VS2015.bat

regedit.exe /S \\IL-AIR-FS01\Software\Scripts\Development\MentorlearnConnectivity\MLDBRegKey.reg
regedit.exe /S \\IL-AIR-FS01\Software\Scripts\Development\MentorlearnConnectivity\VS_2010.reg
regedit.exe /S \\IL-AIR-FS01\Software\Scripts\Development\MentorlearnConnectivity\VS_2013.reg
regedit.exe /S \\IL-AIR-FS01\Software\Scripts\Development\MentorlearnConnectivity\VS_2015.reg