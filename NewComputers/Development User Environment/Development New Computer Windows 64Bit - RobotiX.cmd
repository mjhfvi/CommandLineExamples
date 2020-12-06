ren C:\Users\%username%\Documents\"Visual Studio 2010"\Settings\CurrentSettings* BACKUP_CurrentSettings.vssettings
start cmd /k "xcopy \\SERVER\Software\Installations\Programmers\"Visual Studio"\SettingsForVS\VS2010\CurrentSettings.vssettings C:\Users\%username%\Documents\"Visual Studio 2010"\Settings\"
ren C:\Users\%username%\Documents\"Visual Studio 2013"\Settings\CurrentSettings* BACKUP_CurrentSettings.vssettings
start cmd /k "xcopy \\SERVER\Software\Installations\Programmers\"Visual Studio"\SettingsForVS\VS2013\CurrentSettings.vssettings C:\Users\%username%\Documents\"Visual Studio 2013"\Settings\"
ren C:\Users\%username%\Documents\"Visual Studio 2015"\Settings\CurrentSettings* BACKUP_CurrentSettings.vssettings
start cmd /k "xcopy \\SERVER\Software\Installations\Programmers\"Visual Studio"\SettingsForVS\VS2015\CurrentSettings.vssettings C:\Users\%username%\Documents\"Visual Studio 2015"\Settings\"

start cmd /k "ROBOCOPY "\\SERVER\Software\Scripts\Development\TFS\Team Foundation" "C:\Users\%username%\AppData\Local\Microsoft\Team Foundation" /E /COPY:DAT"
reg import  \\SERVER\Software\Scripts\Development\TFS\AddTeamProjectServer.reg

cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\"
cd
tf workspace /new /s:http://SERVER:8080/tfs/DefaultCollection /noprompt
tf workfold "$/" "C:\SimProjects" /map /collection:http://SERVER:8080/tfs/DefaultCollection /workspace:%computername%

set sourceControlRootFolder="C:\SimProjects"

TF.exe workfold $/PROJECT_NAME  %sourceControlRootFolder%\PROJECT_NAME  
TF.exe get $/PROJECT_NAME  %sourceControlRootFolder%\PROJECT_NAME  							/recursive /force
TF.exe workfold $/PROJECT_NAME  %sourceControlRootFolder%\PROJECT_NAME  

cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\"
C:
devenv /build Debug C:\SimProjects\Solution\PROJECT_NAME.sln

reg import  \\SERVER\Software\Scripts\Development\SERVER\MLDBRegKey.reg
reg import  \\SERVER\Software\Scripts\Development\SERVER\VS_2010.reg
reg import  \\SERVER\Software\Scripts\Development\SERVER\VS_2013.reg
reg import  \\SERVER\Software\Scripts\Development\SERVER\VS_2015.reg

timeout /t -1