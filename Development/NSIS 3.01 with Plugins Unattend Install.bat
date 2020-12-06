\\SERVER\Software\Installations\Programmers\NSIS\nsis-3.01-setup.exe /S
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Include" "\\SERVER\Software\Installations\Programmers\NSIS\Include_3.01" /E /COPY:DAT"
start cmd /k "ROBOCOPY "\\SERVER\Software\Installations\Programmers\NSIS\Plugins" "\\SERVER\Software\Installations\Programmers\NSIS\Include_3.01" /E /COPY:DAT"
