on error resume next


 '************************************************************************************************************************************************
  ' LOG ALL USERS
  ' VBScript Logon script.
  ' Log all User logons To \\SERVER\ServerLogonLogs and call the file Logon.log
  
  
  Dim objLogFile, objNetwork, objShell, strText, intAns
  Dim intConstants, intTimeout, strTitle, intCount, blnLog
  Dim strUserName, strComputerName, strIP, strShare, strLogFile
  
  strShare = "\\SERVER\ServerLogonLogs"
  strLogFile = "Logon.log"
  intTimeout = 20
  
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objNetwork = CreateObject("Wscript.Network")
  Set objShell = CreateObject("Wscript.Shell")
  
  strUserName = objNetwork.UserName
  strComputerName = objNetwork.ComputerName
  strIP = Join(GetIPAddresses())
  
  ' Log date/time, user name, computer name, and IP address.
  If objFSO.FolderExists(strShare) Then
    On Error Resume Next
    Set objLogFile = objFSO.OpenTextFile(strShare & "\" _
      & strLogFile, 8, True, 0)
    If Err.Number = 0 Then
      ' Make three attempts to write to log file.
      intCount = 1
      blnLog = False
      Do Until intCount = 3
        objLogFile.WriteLine "Logon ; "  & Now & " ; " _
          & strComputerName & " ; " & strUserName & " ; " & strIP
        If Err.Number = 0 Then
          intCount = 3
          blnLog = True
        Else
          Err.Clear
          intCount = intCount + 1
          If Wscript.Version > 5 Then
            Wscript.Sleep 200
          End If
        End If
      Loop
      On Error GoTo 0
      If blnLog = False Then
        strTitle = "Logon Error"
        strText = "Log cannot be written."
        strText = strText & vbCrlf _
          & "Another process may have log file open."
        intConstants = vbOKOnly + vbExclamation
        intAns = objShell.Popup(strText, intTimeout, strTitle, _
          intConstants)
      End If
      objLogFile.Close
    Else
      On Error GoTo 0
      strTitle = "Logon Error"
      strText = "Log cannot be written."
      strText = strText & vbCrLf & "User may not have permissions,"
      strText = strText & vbCrLf & "or log folder may not be shared."
      intConstants = vbOKOnly + vbExclamation
      intAns = objShell.Popup(strText, intTimeout, strTitle, intConstants)
    End If
    Set objLogFile = Nothing
  End If
  
  
  
  Function GetIPAddresses()
  '=======================================================================================================
  ' Returns array of IP Addresses as output by ipconfig or winipcfg...
  '
  ' Win98/WinNT have ipconfig (Win95 doesn't)
  ' Win98/Win95 have winipcfg (WinNt doesn't)
  '
  ' Note: The PPP Adapter (Dial Up Adapter) is
  ' excluded if not connected (IP address will be 0.0.0.0)
  ' and included if it is connected.
  '=======================================================================================================
    Dim sh, fso, env, workfile, ts, data, index, n, arIPAddress, parts
  
    set sh = createobject("wscript.shell")
    set fso = createobject("scripting.filesystemobject")
    Set Env = sh.Environment("PROCESS")
    if Env("OS") = "Windows_NT" then
      workfile = Env("TEMP") & "\" & fso.gettempname
      sh.run "%comspec% /c ipconfig >" & Chr(34) _
        & workfile & Chr(34),0,true
    else
      'winipcfg in batch mode sends output to
      'filename winipcfg.out
      workfile = "winipcfg.out"
      sh.run "winipcfg /batch" ,0,true
    end if
    set sh = nothing
    set ts = fso.opentextfile(workfile)
    data = split(ts.readall,vbcrlf)
    ts.close
    set ts = nothing
    fso.deletefile workfile
    set fso = nothing
    arIPAddress = array()
    index = -1
    for n = 0 to ubound(data)
      if instr(data(n),"IP Address") then
        parts = split(data(n),":")
        'if trim(parts(1)) <> "0.0.0.0" then
        if instr(trim(parts(1)), "0.0.0.0") = 0 then
          index = index + 1
          ReDim Preserve arIPAddress(index)
          arIPAddress(index)= trim(cstr(parts(1)))
        end if
      end if
    next
    GetIPAddresses = arIPAddress
  End Function
  
  
  