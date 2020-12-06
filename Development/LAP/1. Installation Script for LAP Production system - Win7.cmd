REM C:\Windows\System32\cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

regedit.exe /S \\il-air-fs01\Software\Scripts\Show_Known_File_Extensions.reg

REM ##Install Team Viewer:
\\il-air-fs01\Software\Installations\Programmers\"Team Viewer"\TeamViewer_Setup.exe /S /norestart
regedit.exe /S \\il-air-fs01\Software\Scripts\Development\Testing\Lap\TeamViewer.reg
powershell.exe -executionpolicy bypass -File .\TeamViewerIDNumber.PS1

REM ##LAP production system installation:

REM ##1.	Framework:
\\il-air-fs01\Versions\MentorLearn\Framework\Common\Framework_v2.0.0.3\setup.exe /S

REM ##2.	Mentorlearn:
\\il-air-fs01\Versions\MentorLearn\VERSIONS\1.5.1.85\"Mentorlearn W7"\setup_win7.exe /S

REM ##3.	Mentorlearn Plugins:

REM GETS STUCK!
REM \\il-air-fs01\Versions\MentorLearn\Module_Plugins\Lap\"Plugins from ori"\Plugins_v4\PluginInstaller_CMDExportColumnsWithBenchmarkService_2016_4_11\MLPluginsInstaller.exe /S
REM \\il-air-fs01\Versions\MentorLearn\Module_Plugins\Lap\"Plugins from ori"\Plugins_v4\PluginInstaller_JandJExportService_2014_6_23\MLPluginsInstaller.exe /S
REM \\il-air-fs01\Versions\MentorLearn\Module_Plugins\Lap\"Plugins from ori"\Plugins_v4\PluginInstaller_JJCaseReport_2014_3_30\MLPluginsInstaller.exe /S
REM \\il-air-fs01\Versions\MentorLearn\Module_Plugins\Lap\"Plugins from ori"\Plugins_v4\PluginInstaller_TraineeReport_2014_1_2\MLPluginsInstaller.exe /S

REM ##4.	Mentorlearn Module Content:
REM GETS STUCK!
REM xcopy \\il-air-fs01\Versions\MentorLearn\ML_Content\LAP\LAP_Content_v1.8\ContentPackageDeployment.exe %TEMP%
REM %TEMP%\ContentPackageDeployment.exe /S
REM del %TEMP%\ContentPackageDeployment.exe

REM ##5.	Hardware Configurator:
\\il-air-fs01\Versions\"LAP Mentor"\"Hardware configuration"\1.24.1052.13\HWConfig_1.24.1052.13_Setup.exe /S

REM ##6.	LapTab:
\\il-air-fs01\Versions\"LAP Mentor"\Modules\Hardware\"Lap Tab"\1.0.0.6\Lap_Tab_1.0.0.6_Setup.exe /S

REM ##7.	Module installations:
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Laparoscopic Basic Skills"\1.9.0.2\Laparoscopic_Basic_Skills_1.9.0.2_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Procedural Tasks LapChole"\2.2.0.2\Procedural_Tasks_LapChole_2.2.0.2_Setup.exe /S
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Full Procedures LapChole"\2.3.0.0\Full_Procedures_LapChole_2.3.0.0_Setup.exe /S
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
\\il-air-fs01\Versions\"LAP Mentor"\Modules\"Myoma Suturing"\2017.10.25.1\MyomaSuturing_2017.10.25.1_Setup.exe /S

\\il-air-fs01\Versions\"LAP Mentor"\Modules\Hardware\"LAP Prerequisites"\1.0.0.1\Lap_Prerequisites_1.0.0.1_Setup.exe /S


REM ## Oculus:
\\il-air-fs01\Software\Installations\Programmers\Oculus\OculusSetup.exe

pause
