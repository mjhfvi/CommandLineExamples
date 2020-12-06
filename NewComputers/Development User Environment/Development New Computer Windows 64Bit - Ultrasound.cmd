ren C:\Users\%username%\Documents\"Visual Studio 2010"\Settings\CurrentSettings* BACKUP_CurrentSettings.vssettings
start cmd /k "xcopy \\SERVER\Software\Installations\Programmers\"Visual Studio"\SettingsForVS\VS2010\CurrentSettings.vssettings C:\Users\%username%\Documents\"Visual Studio 2010"\Settings\"
ren C:\Users\%username%\Documents\"Visual Studio 2013"\Settings\CurrentSettings* BACKUP_CurrentSettings.vssettings
start cmd /k "xcopy \\SERVER\Software\Installations\Programmers\"Visual Studio"\SettingsForVS\VS2013\CurrentSettings.vssettings C:\Users\%username%\Documents\"Visual Studio 2013"\Settings\"
ren C:\Users\%username%\Documents\"Visual Studio 2015"\Settings\CurrentSettings* BACKUP_CurrentSettings.vssettings
start cmd /k "xcopy \\SERVER\Software\Installations\Programmers\"Visual Studio"\SettingsForVS\VS2015\CurrentSettings.vssettings C:\Users\%username%\Documents\"Visual Studio 2015"\Settings\"

start cmd /k "ROBOCOPY "\\SERVER\Software\Scripts\Development\TFS\Team Foundation" "C:\Users\%username%\AppData\Local\Microsoft\Team Foundation" /E /COPY:DAT"
reg import \\SERVER\Software\Scripts\Development\TFS\AddTeamProjectServer.reg

setx path "%path%;D:\Projects\USDepends"

cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\"
cd
tf workspace /new /s:http://SERVER:8080/tfs/DefaultCollection /noprompt
tf workfold "$/" "C:\SimProjects" /map /collection:http://SERVER:8080/tfs/DefaultCollection /workspace:%computername%

set sourceControlRootFolder="C:\Projects"


TF.exe workfold $/PROJECT_NAME  %sourceControlRootFolder%\PROJECT_NAME  
TF.exe get $/PROJECT_NAME  %sourceControlRootFolder%\PROJECT_NAME  					/recursive /force

mkdir D:\Projects\PROJECT_NAME \Module\
mkdir D:\Projects\PROJECT_NAME \Module-branch\
echo $null >> D:\Projects\PROJECT_NAME \Module\case_load.txt
echo $null >> D:\Projects\PROJECT_NAME \Module-branch\case_load.txt

timeout /t -1