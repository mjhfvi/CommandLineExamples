  on error resume next
  
  'RUN A PROGRAM ON A USERS MACHINE.
  '===========================================================================================================
  WshShell.Run "\\SERVER\SHARE\PROGRAM.exe", 0, True
  Wscript.Run "\\SERVER\SHARE\runme.bat",0, True 'THE 0 WILL CAUSE THE DOS BOX TO BE HIDDEN