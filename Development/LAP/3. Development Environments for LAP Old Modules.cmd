\\il-air-fs01\Software\Installations\Microsoft\OfficeAllVersions\Office2016\SW_DVD5_Office_Professional_Plus_2016_64Bit_English_MLF_X20-42432\setup  /adminfile \\il-air-fs01\Software\Installations\Microsoft\OfficeAllVersions\Office2016\SW_DVD5_Office_Professional_Plus_2016_64Bit_English_MLF_X20-42432\unattended.MSP
"\\il-air-fs01\Software\Installations\Programmers\Visual Studio\Visual Studio 2010\en_visual_studio_2010_professional_x86_dvd_509727\setup\Setup.exe" /Passive /Full /NoRestart
"\\il-air-fs01\Software\Installations\Programmers\Visual Studio\Visual Studio 2010\mu_visual_studio_2010_sp1_x86_dvd_651704\Setup.exe" /Q /NoRestart
REM \\il-air-fs01\Software\Installations\Programmers\"Team Explorer"\tfpt.msi /quiet
"\\il-air-fs01\Software\Installations\Programmers\Visual Studio\Visual Studio 2013\en_visual_studio_professional_2013_with_update_5_x86_dvd_6815752\vs_professional.exe" /Passive /Full /NoRestart

REM DON'T WORK
REM \\il-air-fs01\Software\Installations\7zip\7z920-x64.msi /quiet
REM \\il-air-fs01\Software\Installations\Programmers\Python\python-2.6.4.msi /quiet
xcopy \\il-air-fs01\Software\Installations\7zip\7z920-x64.msi "%TEMP%" /n
"%TEMP%\7z920-x64.msi" /quiet
del "%TEMP%\7z920-x64.msi"

xcopy \\il-air-fs01\Software\Installations\Programmers\Python\python-2.6.4.msi "%TEMP%" /n
"%TEMP%\python-2.6.4.msi" /qn
del "%TEMP%\python-2.6.4.msi"

pause