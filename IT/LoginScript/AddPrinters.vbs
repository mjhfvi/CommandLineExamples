'@echo off


on error resume next

Set objSysInfo = CreateObject("ADSystemInfo")
Set objNetwork = CreateObject("Wscript.Network")

'find user name

strUserPath = "LDAP://" & objSysInfo.UserName
Set objUser = GetObject(strUserPath)

'find user group's

For Each strGroup in objUser.MemberOf
strGroupPath = "LDAP://" & strGroup
Set objGroup = GetObject(strGroupPath)
strGroupName = objGroup.CN

' if user member of a group then Add Printer

''' Add Main Printer to All Simbionix Users
Select Case strGroupName
Case "ILAIR_Users"
   Set net = CreateObject("WScript.Network")    
   net.AddWindowsPrinterConnection "\\SERVER\MainPrinterXerox"  
   

''' Add Sales Printer to users

Case "ILAIR_DEV"
	objNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"


Case "ILAIR_Sales"
   Set net = CreateObject("WScript.Network")    
   net.AddWindowsPrinterConnection "\\SERVER\SalesPrinterXerox" 
   objNetwork.SetDefaultPrinter "\\SERVER\SalesPrinterXerox"


Case "ILAIR_DEV_Graphics"
	objNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox" 


Case "ILAIR_QA"
	Set net = CreateObject("WScript.Network")    
	net.AddWindowsPrinterConnection "\\SERVER\SalesPrinterXerox"
	Set net = CreateObject("WScript.Network")    
	net.AddWindowsPrinterConnection "\\SERVER\ManufacturingPrinterSharp"
	objNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox" 


Case "ILAIR_ProductManagers"
	objNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox" 


Case "ILAIR_Marketing"
	objNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox"  


	Case "ILAIR_IT"
	Set net = CreateObject("WScript.Network")    
	net.AddWindowsPrinterConnection "\\SERVER\MainPrinterXerox" 
	Set net = CreateObject("WScript.Network")    
	net.AddWindowsPrinterConnection "\\SERVER\SalesPrinterXerox"
	Set net = CreateObject("WScript.Network")    
	net.AddWindowsPrinterConnection "\\SERVER\ManufacturingPrinterSharp"	
   	objNetwork.SetDefaultPrinter "\\SERVER\MainPrinterXerox" 
   
'
End Select
Next

'end script