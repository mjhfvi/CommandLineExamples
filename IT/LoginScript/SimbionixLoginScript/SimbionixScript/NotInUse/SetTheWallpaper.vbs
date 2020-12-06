
on error resume next


  'Set the wallpaper
  strComputer = "."
  Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
  Set colItems = objWMIService.ExecQuery("Select * from Win32_VideoController",,48)
  Set WshShell = WScript.CreateObject("WScript.Shell")
  Set WshSysEnv = WshShell.Environment("Process")
  Set FSO = CreateObject("Scripting.FileSystemObject")
    WinPath = WshEnv("SystemRoot") & "\Wallpaper.bmp"
   
  If Not objFSO.FileExists(winpath) then
  'If the file does not exist then copy it
  For Each objItem in colItems 
      sourcePath = "\\SERVER\SHARE\ScreenSaver\"
      rightSize = "GT" & objItem.CurrentHorizontalResolution & "x" & objItem.CurrentVerticalResolution & ".bmp"
      objFSO.CopyFile sourcePath & rightSize, WSHShell.ExpandEnvironmentStrings ("%SystemRoot%") & "\Wallpaper.bmp", overwrite = False
  Next
  End If