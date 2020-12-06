Set WshNetwork = WScript.CreateObject("WScript.Network")
Set WshShell = CreateObject("wScript.Shell")

Dim objSWbemServices,colSWbemObjectSet,objSWbemObject
Set objSWbemServices = GetObject("winmgmts:\\.\root\cimv2")
Set colSWbemObjectSet = objSWbemServices.InstancesOf("Win32_OperatingSystem")

For Each objSWbemObject In colSWbemObjectSet
objSWbemObject.Description = strDescription
On Error Resume Next
objSWbemObject.Put_
Next