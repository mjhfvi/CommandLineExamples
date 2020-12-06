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

' if user member of a group then map network drive

Select Case strGroupName
Case "ILAIR_Users"
objNetwork.MapNetworkDrive "W:", "\\SERVER\Software\Installations"

Case "ILAIR_Finance" 
objNetwork.MapNetworkDrive "O:", "\\SERVER\Finance"

Case "ILAIR_DEV"
objNetwork.MapNetworkDrive "Y:", "\\SERVER\Development"
objNetwork.MapNetworkDrive "R:", "\\SERVER\Projects"

Case "ILAIR_IT"
objNetwork.MapNetworkDrive "T:", "\\SERVER\InformationTechnology"

Case "ILAIR_Sales"
objNetwork.MapNetworkDrive "S:", "\\SERVER\Sales"

Case "ILAIR_DEV_Graphics"
objNetwork.MapNetworkDrive "X:", "\\SERVER\Graphics"

Case "ILAIR_QA"
objNetwork.MapNetworkDrive "Q:", "\\SERVER\QualityAssurance"

Case "ILAIR_ProductManagers"
objNetwork.MapNetworkDrive "P:", "\\SERVER\ProductManagers"
objNetwork.MapNetworkDrive "R:", "\\SERVER\Projects"

Case "ILAIR_Production"
objNetwork.MapNetworkDrive "O:", "\\SERVER\Production"

Case "ILAIR_Marketing"
objNetwork.MapNetworkDrive "M:", "\\SERVER\Marketing"
'
End Select
Next

'end script