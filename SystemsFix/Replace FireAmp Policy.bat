net stop ImmunetProtect
ren %PROGRAMFILES%\Sourcefire\fireAMP\policy.xml %PROGRAMFILES%\Sourcefire\fireAMP\policy.xml.backup
copy \\SERVER\Software\Installations\FireAmp\policy.xml %PROGRAMFILES%\Sourcefire\fireAMP\
