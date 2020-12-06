net Localgroup Administrators GROUP /add
setx /m REALP4ROOT;C:\

\\SERVER\Software\Installations\Zip\winrar-x64-571.exe /S
\\SERVER\Software\Installations\Notepad++\npp.7.5.5.installer.x64.msi /qb
\\SERVER\Software\Installations\Dev\FinalBuilder\FB800_2538.exe /SILENT
\\SERVER\Software\Installations\Dev\VTuneTM\2018\VTune_Amplifier_2018_setup\setup.exe install --eula=accept --update=always --components=all --eval=install --output=C:\VTuneTM_output.txt


\\SERVER\Software\Installations\Dev\Rational\IBMInstallationManager\agent.installer.win32.win32.x86_64_1.9.0.20190715_0328\installc.exe -accessRights admin -showProgress -silent -acceptLicense

net use Z: "\\SERVER\Software\Installations\Microsoft\Visual Studio\Visual Studio Enterprise 2017"
Z:\vs_setup.exe --passive --norestart --productKey PFM3DCNM29XFKTB4QJFT8T2DG
\\SERVER\Software\Installations\Dev\"Visual Assist"\VA_X_Setup\VA_X_Setup2248_0.exe /S /LU "LICENSE-KEY"


\\SERVER\Software\Installations\Dev\Rational\Cimatron_Tools\Result\cimatron_tools.exe
\\SERVER\Software\Installations\Dev\Araxis\merge65_win32_2318.exe

\\SERVER\p4util6\Install_10\setup.exe

timeout /t -1