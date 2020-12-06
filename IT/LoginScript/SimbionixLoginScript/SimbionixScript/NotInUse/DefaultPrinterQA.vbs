@echo off


on error resume next

'== Set QA Printer As default \\SERVER\QAPrinterHP

Set PrinterPath = "\\SERVER\QAPrinterHP"
Set WshNetwork = WScript.CreateObject("WScript.Network")
Set rc = WshNetwork.AddWindowsPrinterConnection(PrinterPath)
If Not rc then
      WScript.Echo("Printer Connection Failed!")
End If
WshNetwork.SetDefaultPrinter PrinterPath