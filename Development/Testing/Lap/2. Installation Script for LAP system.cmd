C:\Windows\System32\cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
regedit.exe /S \\il-air-fs01\Software\Scripts\Show_Known_File_Extensions.reg


REM ##LAP production system installation:

REM ##1.	Framework:
\\il-air-fs01\Versions\MentorLearn\Framework\Common\Framework_v2.0.0.3\setup.exe /S

REM ##2.	Mentorlearn:
\\il-air-fs01\Versions\MentorLearn\VERSIONS\1.5.1.85\"Mentorlearn W7"\setup_win7.exe /S

REM ##4.	Mentorlearn Module Content:
\\il-air-fs01\Versions\MentorLearn\ML_Content\LAP\LAP_Content_v1.8\ContentPackageDeployment.exe /S

REM ##5.	Hardware Configurator:
\\il-air-fs01\Versions\"LAP Mentor"\"Hardware configuration"\Version 1.0.5.1.1051\Setup 1.0.5.1.1051.exe /S

REM ##6.	LapTab:
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Hardware\"Lap Tab"\1.0.0.1\"LAP TAB_1.0.0.1_Setup.exe" /S

REM ##7.	Module installations:
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Laparoscopic Basic Skills"\1.9.0.1\Laparoscopic_Basic_Skills_1.9.0.1_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Procedural Tasks LapChole"\2.2.0.1\Procedural_Tasks_LapChole_2.2.0.1_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Full Procedures LapChole"\2.2.0.1\Full_Procedures_LapChole_2.2.0.1_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Suturing Skills"\1.3.0.5\SuturingSkills_1.3.0.5_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Advanced Suturing Skills"\1.3.0.5\AdvancedSuturingSkills_1.3.0.5_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\GastricBypass\1.3.0.10\GastricBypass_1.3.0.10_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Incisional Hernia"\1.4.0.13\Hernia_1.4.0.13_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Sigmoidectomy\1.7.0.10\Sigmoidectomy_1.7.0.10_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Gynecology\2.1.0.5\Gynecology_2.1.0.5_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\LET\1.0.0.10\Laparoscopic_Essential_Tasks_1.0.0.10_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Nephrectomy\1.0.0.11\Nephrectomy_1.0.0.11_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Hysterectomy\1.1.0.2\Hysterectomy_1.1.0.2_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Appendectomy\2.1.0.2\Appendectomy_2.1.0.2_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Vaginal Cuff Closure"\1.0.1.2\VaginalCuffClosure_1.0.1.2_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Lobectomy\2.0.0.4\Lobectomy_2.0.0.4_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Cholangiography\1.0.0.4\Cholangiography_1.0.0.4_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Inguinal Hernia"\1.0.0.5\InguinalHernia_1.0.0.5_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Myoma Suturing"\1.0.0.0\MyomaSuturing_1.0.0.0_Setup.exe /S

REM ##8.	Oculus:
RAM ##Win7 pre-requisites:
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Hardware\"LAP VR"\NDP451-KB2858728-x86-x64-AllOS-ENU.exe /passive /norestart
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Hardware\"LAP VR"\Windows6.1-KB2670838-x64.msu /passive /norestart
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Hardware\"LAP VR"\Windows6.1-KB3033929-x64.msu /passive /norestart

REM ##Install Team Viewer:
\\il-air-fs01\Software\Installations\Programmers\"Team Viewer"\TeamViewer_Setup.exe /S /norestart
regedit.exe /S \\il-air-fs01\Software\Scripts\Development\Testing\Lap\TeamViewer.reg
powershell.exe -executionpolicy bypass -File .\TeamViewerIDNumber.PS1



REM ##Install WTV (probably not installer � copy somewhere and create a link on the desktop):
xcopy \\il-air-fs01\Development\LAP\Utilities\WTV\WTV.exe C:\"Program Files"\
xcopy \\il-air-fs01\Development\LAP\Utilities\WTV\"WTV.exe - Shortcut.lnk" %USERPROFILE%\desktop

REM ##Install MView (probably not installer � copy somewhere and create a link on the desktop):
\\il-air-fs01\Development\LAP\Utilities\"Mesh Viewer"\mview.exe
xcopy \\il-air-fs01\Development\LAP\Utilities\"Mesh Viewer"\mview.exe C:\"Program Files"\
xcopy \\il-air-fs01\Development\LAP\Utilities\"Mesh Viewer"\"mview.exe - Shortcut.lnk" %USERPROFILE%\desktop

C:\Projects\Sim-Engine\sim_engine_get.bat

REM ## installation of Unity to the R&D 
\\IL-AIR-FS01\Software\Installations\Programmers\Unity\UnitySetup64-5.5.1f1.exe /S

REM ##3.	Mentorlearn Plugins:
\\il-air-fs01\Versions\MentorLearn\Module_Plugins\Lap\"Plugins from ori"\Plugins_v4\PluginInstaller_CMDExportColumnsWithBenchmarkService_2016_4_11\MLPluginsInstaller.exe
\\il-air-fs01\Versions\MentorLearn\Module_Plugins\Lap\"Plugins from ori"\Plugins_v4\PluginInstaller_JandJExportService_2014_6_23\MLPluginsInstaller.exe
\\il-air-fs01\Versions\MentorLearn\Module_Plugins\Lap\"Plugins from ori"\Plugins_v4\PluginInstaller_JJCaseReport_2014_3_30\MLPluginsInstaller.exe
\\il-air-fs01\Versions\MentorLearn\Module_Plugins\Lap\"Plugins from ori"\Plugins_v4\PluginInstaller_TraineeReport_2014_1_2\MLPluginsInstaller.exe

REM ##Copy SimEditor reflection from main branch to desktop � create a shortcut from:
C:\Projects\Main\BasicStuff\ReflectionSystem\Applications\SimEditor\bin\Release\SimEditor.exe

\\il-air-fs01\Software\Installations\Programmers\Oculus\OculusSetup.exe
