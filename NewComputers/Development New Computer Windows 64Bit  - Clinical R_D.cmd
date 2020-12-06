net Localgroup Administrators GROUP /add
xcopy \\SERVER\Software\Installations\3DIT c:\3DIT\ /y
# \\SERVER\Software\Installations\7zip\7z920-x64.msi /qb
#\\SERVER\Software\Installations\Adobe\"Adobe Acrobat"\AcroRdrDC1501020056_en_US.exe /sAll
\\SERVER\Software\Installations\GoogleApps\googlechromestandaloneenterprise64.msi /qb
\\SERVER\Software\Installations\"Firefox Setup 44.0.2.exe" /s
\\SERVER\Software\Installations\Java\jre-8u73-windows-x64.exe /s
# \\SERVER\Software\Installations\Programmers\Notepad++\npp.6.8.8.Installer.exe /S
#\\SERVER\Software\Installations\Jabber\CiscoJabberSetup.msi /qb
#\\SERVER\Software\Installations\Microsoft\OfficeAllVersions\Office2016\SW_DVD5_Office_Professional_Plus_2016_64Bit_English_MLF_X20-42432\setup  /adminfile \\SERVER\Software\Installations\Microsoft\OfficeAllVersions\Office2016\SW_DVD5_Office_Professional_Plus_2016_64Bit_English_MLF_X20-42432\unattended.MSP
#\\SERVER\Software\Installations\FireAmp\3D_Clients_FireAMPSetup.exe /S
\\SERVER\Software\Installations\Programmers\"Beyond Compare"\BCompare-4.1.3.20814.exe /SILENT /NORESTART @@BC4Key
#dism /online /add-package /packagepath:\\SERVER\Software\Drivers\microsoft-windows-netfx3-ondemand-package.cab
\\SERVER\Software\Installations\Programmers\"DirectX SDK"\"DirectX 11.0 June 2010"\DXSDK_Jun10.exe /U
\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2013"\en_visual_studio_professional_2013_with_update_5_x86_dvd_6815752\vs_professional.exe /Passive /Full /NoRestart
\\SERVER\Software\Installations\Programmers\"Visual Studio"\"Visual Studio 2015"\vs_professional.exe /Passive /Full /NoRestart /ProductKey LICENSE-KEY
\\SERVER\Software\Installations\Programmers\"Team Foundation Server"\"Team Foundation Server Power Tools"\tfpt_2015.msi /qb
\\SERVER\Software\Installations\Programmers\"Visual Assist"\"Visual Assist X"\VA_X_Setup2089.exe /S
\\SERVER\Software\Installations\Programmers\XML\"XML Notepad 2007"\XmlNotepad.msi /passive
\\SERVER\Software\Installations\Programmers\NSIS\nsis-2.46-setup.exe /S
ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Include" "C:\Program Files (x86)\NSIS\Include" /E /COPY:DAT
ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Plugins" "C:\Program Files (x86)\NSIS\Plugins" /E /COPY:DAT
cscript.exe \\SERVER\Software\Scripts\IT\LoginScript\AddPrinters.vbs
\\SERVER\Software\Scripts\InternationalSettings.reg /y
regedit.exe /S \\SERVER\Software\Scripts\Development\MentorlearnConnectivity\MLDBRegKey.reg
regedit.exe /S \\SERVER\Software\Scripts\Development\MentorlearnConnectivity\VS_2010.reg
regedit.exe /S \\SERVER\Software\Scripts\Development\MentorlearnConnectivity\VS_2013.reg
regedit.exe /S \\SERVER\Software\Scripts\Development\MentorlearnConnectivity\VS_2015.reg