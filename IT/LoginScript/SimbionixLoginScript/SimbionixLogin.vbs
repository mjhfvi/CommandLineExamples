'@echo off


on error resume next

'====== Skip Login on Servers, Check if this is a Server. If this is a server quit
  Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
  Set colItems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem",,48)
  For Each objItem in colItems
      If InStr(1,objItem.Caption,"Server") Then Wscript.Quit
  Next

'====== Drive Mapping
Set objShell = CreateObject("WScript.Shell")
objShell.run("cscript \DriveMap.vbs")

'====== Add All Printers
Set objShell = CreateObject("WScript.Shell")
objShell.run("cscript \AddAllPrinters.vbs")

'====== Default Printer  Mapping
Set objShell = CreateObject("WScript.Shell")
objShell.run("cscript \DefaultPrinterCheck.vbs")

'====== One Time Login To The Domain
'Set objShell = CreateObject("WScript.Shell")
'objShell.run("cscript OneTimeLogin.vbs")

