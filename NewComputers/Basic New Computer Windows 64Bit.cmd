DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:"\\SERVER\Software\ISO\Windows 10\SW_DVD9_Win_Pro_10_1909_64BIT_English_Pro_Ent_EDU_N_MLF_X22-17395\sources\sxs"
\\SERVER\Software\Installations\7zip\7z1900-x64.msi /qb
\\SERVER\Software\Installations\IT\ElevatePermissions\Elevate11\Elevate64.exe msiexec /qn /I \\SERVER\Software\Installations\Avamar\Laptops\AvamarClient-windows-x86_64-7.2.101-32.msi WORKSTATION=1 SERVER=SERVER DOMAIN=/clients GROUP="/Windows OS DTLT Group" UICOMPONENT=1  PROGRESSBAR=true BALLOONMESSAGE=true
\\SERVER\Software\Installations\Adobe\"Adobe Acrobat"\AcroRdrDC1901220034_en_US.exe /sAll
\\SERVER\Software\Installations\Google\GoogleChromeEnterpriseBundle64\Installers\googlechromestandaloneenterprise64.msi /qb
\\SERVER\Software\Installations\Cisco\Jabber\CiscoJabberSetup.msi /qb
cd %PROGRAMFILES(X86)%\Cisco Systems\Cisco Jabber\
ren jabber-config-defaults.xml jabber-config-defaults.xml.old
xcopy \\SERVER\Software\Scripts\IT\jabber-config-defaults.xml "%PROGRAMFILES(X86)%\Cisco Systems\Cisco Jabber\" /y
\\SERVER\Software\Installations\Microsoft\Teams\Teams_windows_x64.msi /qb
\\SERVER\Software\Installations\Mozilla\Firefox-44.0.2-en-US-silent.exe
\\SERVER\Software\Installations\Drivers\HP\"Client Management Solutions - HP drivers (SoftPaqs) downloads"\HP_SDM_Setup\setup.msi /qb
\\SERVER\Software\Installations\Java\jre-8u191-windows-x64.exe /s
\\SERVER\Software\Installations\Microsoft\Office\Office365\setup.exe /configure \\SERVER\Software\Installations\Microsoft\Office\Office365\OfficeInstall.xml
"\\IL-AIR-FS01\Software\Installations\IT\SCCM client\ccmsetup.exe"

reg import \\SERVER\Software\Scripts\InternationalSettings.reg
reg import \\SERVER\Software\Scripts\Show_Known_File_Extensions.reg

\\SERVER\Software\Installations\Cisco\FireAMP\3D_Clients_FireAMPSetup.exe /S



timeout /t -1