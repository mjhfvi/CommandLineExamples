ECHO OFF
CLS
:MENU
ECHO.
ECHO ...............................................
ECHO Select Your User Environment From The List.
ECHO ...............................................
ECHO.
ECHO 1 - Install Angio Environment
ECHO 2 - Install Clinical Environment
ECHO 3 - Install GI Environment
ECHO 4 - Install LAP Environment
ECHO 5 - Install RobotiX Environment
ECHO 6 - Install Ultrasound Environment
ECHO.
SET /P M=Type 1, 2, 3, 4, 5, or 6 then press ENTER:
IF %M%==1 GOTO Angio
IF %M%==2 GOTO Clinical
IF %M%==3 GOTO GI
IF %M%==4 GOTO LAP
IF %M%==5 GOTO RobotiX
IF %M%==6 GOTO Ultrasound
:Angio
start cmd /k "\\SERVER\Software\Scripts\New Computers\Development User Environment\Development New Computer Windows 64Bit - Angio.cmd"
GOTO MENU
:Clinical
start cmd /k "\\SERVER\Software\Scripts\New Computers\Development User Environment\Development New Computer Windows 64Bit - Clinical.cmd"
GOTO MENU
:GI
start cmd /k "\\SERVER\Software\Scripts\New Computers\Development User Environment\Development New Computer Windows 64Bit - GI.cmd"
GOTO MENU
:LAP
start cmd /k "\\SERVER\Software\Scripts\New Computers\Development User Environment\Development New Computer Windows 64Bit - LAP Team.cmd"
GOTO MENU
:RobotiX
start cmd /k "\\SERVER\Software\Scripts\New Computers\Development User Environment\Development New Computer Windows 64Bit - RobotiX.cmd"
GOTO MENU
:Ultrasound
start cmd /k "\\SERVER\Software\Scripts\New Computers\Development User Environment\Development New Computer Windows 64Bit - Ultrasound.cmd"
GOTO MENU
