\\SERVER\Software\Installations\Dev\Rational\IBMInstallationManager\agent.installer.win32.win32.x86_64_1.9.0.20190715_0328\installc.exe -accessRights admin -showProgress -silent -acceptLicense

\\SERVER\Software\Installations\IT\ElevatePermissions\Elevate11\Elevate64.exe "%ProgramFiles%\IBM\Installation Manager\eclipse\tools\imcl.exe" -acceptLicense -input \\SERVER\Software\Installations\Dev\Rational\IBMInstallationManager\ResponseFileClearQuest.xml
TIMEOUT /T 600

\\SERVER\Software\Installations\IT\ElevatePermissions\Elevate11\Elevate64.exe "%ProgramFiles(x86)%\IBM\RationalSDLC\ClearQuest\cqdbsetup.exe" -I \\SERVER\Software\Installations\Dev\Rational\IBMInstallationManager\CQprofile.ini





