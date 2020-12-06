ON ERROR RESUME NEXT
  'THIS WILL PREVENT THE LOGON SCRIPT FROM RUNNING EVERY TIME A USER LOGS ONTO THE NETWORK
' RunLogonScriptOnceADay 

'====== Disable User Account Control (UAC)
'C:\Windows\System32\cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f


'====== Install Softwares
Dim objShell
Set objShell = WScript.CreateObject( "WScript.Shell" )
objShell.Run("""\\SERVER\installations\Symantec\SEP12.1.6mp1a_Clients New_WIN64BIT.exe""")
Set objShell = Nothing


  'RUN A PROGRAM ON A USERS MACHINE.
  '===========================================================================================================
'  WshShell.Run "\\SERVER\INSTALLATIONS\Mozilla\Firefox-44.0.2-en-US-silent.exe", 0, True
'  Wscript.Run "\\SERVER\INSTALLATIONS\Scripts\Development\Beyond Compare 4 Unattend Install.cmd",1, True 	'THE 0 WILL CAUSE THE DOS BOX TO BE HIDDEN