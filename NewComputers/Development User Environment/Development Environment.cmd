\\SERVER\Software\Installations\Programmers\NSIS\nsis-2.46-setup.exe /S
ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Include" "C:\Program Files (x86)\NSIS\Include" /E /COPY:DAT
ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Plugins" "C:\Program Files (x86)\NSIS\Plugins" /E /COPY:DAT
\\SERVER\Software\Installations\Programmers\Python\python-2.6.4.msi /qb
\\SERVER\Software\Installations\Programmers\Python\python-2.7.12.msi /qb
ROBOCOPY "\\SERVER\Software\Installations\Programmers\Boost\boost_1_45_0" "C:\Program Files (x86)\boost\boost_1_45_0" /E /COPY:DAT
