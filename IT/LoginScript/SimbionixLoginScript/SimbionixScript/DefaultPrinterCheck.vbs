
  ON ERROR RESUME NEXT
  'THIS WILL PREVENT THE LOGON SCRIPT FROM RUNNING EVERY TIME A USER LOGS ONTO THE NETWORK
RunLogonScriptOnceADay 
  '==========================================================================
  
  Dim WSHShell, WSHNetwork, objDomain, DomainString, UserString, UserObj, Path, strKey
  Dim strFullname, WshEnv, objFSO, WshSysEnv, LServer, Username, SWidth, SHeight, strBitmap, SysDrive
  Dim filesys, fso, tempiepath, oShell, oEnvironment, oNetwork, bYesClick, bNoClick, bUserClose, bOKClick
  
  Set filesys=CreateObject("Scripting.FileSystemObject")
  Set WSHShell = CreateObject("WScript.Shell")
  Set WSHNetwork = CreateObject("WScript.Network")
  Set WshShell = WScript.CreateObject("WScript.Shell")
  Set WshSysEnv = WshShell.Environment("Process")
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set oShell = CreateObject("WScript.Shell")
  
  
  'Automatically find the domain name
  Set objDomain = getObject("LDAP://rootDse")
  DomainString = objDomain.Get("dnsHostName")
  
  'Grab the user name
  UserString = WSHNetwork.UserName
  Set objADSysInfo = CreateObject("ADSystemInfo")
  Set objCurrentUser = GetObject("LDAP://" & objADSysInfo.UserName)
  
  'Bind to the user object to get user name and check for group memberships later
  Set UserObj = GetObject("WinNT://" & DomainString & "/" & UserString)
  
  
  'Grab the computer name for use in add-on code later
  strComputer = WSHNetwork.ComputerName
  '************************************************************************************************************************************************

  'Install Printers
     
              WSHNetwork.AddWindowsPrinterConnection "\\SERVER\MainPrinterXerox"	'== Add Main Printer
              WSHNetwork.AddWindowsPrinterConnection "\\SERVER\SalesPrinterXerox"	'== Add Sales Printer
			  WSHNetwork.AddWindowsPrinterConnection "\\SERVER\QAPrinterHP"		'== Add QA Printer
                
  For Each GroupObj In UserObj.Groups
      Select Case GroupObj.Name
      'Check for group memberships and take needed action
      'In this example below, ADMIN and Partners and Clerks are groups.
       
          Case "ILAIR_Finance" 
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"
              
          Case "ILAIR_HR"
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"
              
          Case "ILAIR_DEV"
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"
              
          Case "ILAIR_IT"
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"
              
          Case "ILAIR_DEV_Graphics"
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"
			  
          Case "ILAIR_ProductManagers"
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"
			  
          Case "ILAIR_Production"
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"
              
          Case "ILAIR_Management"
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"

		  Case "ILAIR_Marketing"
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"
              
          Case "ILAIR_QA"
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\QAPrinterHP"
			  
          Case "ILAIR_Sales"
              'Below is an example of how to set the default printer
              WSHNetwork.SetDefaultPrinter "\\SERVER\SalesPrinterXerox"
			  
              
      End Select
  Next