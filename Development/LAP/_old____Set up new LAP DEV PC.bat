@echo off
@echo Copying Reflection SimEditor to desktop
md C:\Users\Owner\Desktop\SimEditor
xcopy "\\IL-AIR-FS01\Development\LAP\Utilities\SimEditor" "C:\Users\Owner\Desktop\SimEditor\*" /E
@echo Copying Module0012 R&D folder to desktop
md C:\Users\Owner\Desktop\Module0012_DEV
xcopy "\\IL-AIR-FS01\Development\LAP\SimEngine\Module0012" "C:\Users\Owner\Desktop\Module0012_DEV\*" /E
@echo Installing Beyond Compare
"\\IL-AIR-FS01\Software\Installations\Programmers\Beyond Compare\BCompare-4.1.3.20814.exe" /SILENT
@echo Installing Team Viewer
"\\IL-AIR-FS01\Software\Installations\Programmers\Team Viewer\TeamViewer_Setup.exe"

