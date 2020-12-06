DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:\\SERVER\Software\ISO\Windows\VolumeLicensing\SW_DVD9_Win_Pro_10_1903_64BIT_English_Pro_Ent_EDU_N_MLF_X22-02890\sources\sxs
\\SERVER\Software\Installations\7zip\7z1900-x64.msi /qb
\\SERVER\Software\Installations\Adobe\"Adobe Acrobat"\AcroRdrDC1901220034_en_US.exe /sAll
\\SERVER\Software\Installations\Google\GoogleChromeEnterpriseBundle64\Installers\googlechromestandaloneenterprise64.msi /qb
"\\SERVER\Software\Installations\Mozilla\Firefox Setup 66.0.3.msi" /qb
\\SERVER\Software\Installations\Jabber\CiscoJabberSetup.msi /qb
ren "%PROGRAMFILES(X86)%\"Cisco Systems"\jabber-config-defaults.xml jabber-config-defaults.xml.old
xcopy \\SERVER\Software\Installations\Jabber\jabber-config-defaults.xml "%PROGRAMFILES(X86)%\Cisco Systems\Cisco Jabber\" /y
\\SERVER\Software\Installations\Microsoft\Teams\Teams_windows_x64.msi /qb
\\SERVER\Software\Drivers\HP\HPSupportsp82049\Setup.exe /s
\\SERVER\Software\Drivers\HP\"Client Management Solutions - HP drivers (SoftPaqs) downloads"\HP_SDM_Setup\setup.msi /qb
\\SERVER\Software\Installations\Microsoft\OfficeAllVersions\Office365\setup.exe /configure \\SERVER\Software\Installations\Microsoft\OfficeAllVersions\Office365\OfficeInstall.xml

\\SERVER\Software\Scripts\IT\ElevatePermissions\Elevate11\Elevate64.exe msiexec /qn /I \\SERVER\Software\Installations\Avamar\Laptops\AvamarClient-windows-x86_64-7.2.101-32.msi WORKSTATION=1 SERVER=SERVER DOMAIN=/clients GROUP="/Windows OS DTLT Group" UICOMPONENT=1  PROGRESSBAR=true BALLOONMESSAGE=true
"\\SERVER\Software\Installations\IT\SCCM client\ccmsetup.exe"

reg import \\SERVER\Software\Scripts\InternationalSettings.reg
reg import \\SERVER\Software\Scripts\Show_Known_File_Extensions.reg

\\SERVER\Software\Installations\FireAmp\3D_Clients_FireAMPSetup.exe /S


timeout /t -1