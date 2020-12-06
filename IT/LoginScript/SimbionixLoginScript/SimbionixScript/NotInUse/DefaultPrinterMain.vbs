@echo off


on error resume next

'== Set Main Printer As default \\SERVER\MainPrinterXerox

Set PrinterPath = "\\SERVER\MainPrinterXerox"
Set WshNetwork = WScript.CreateObject("WScript.Network")
Set rc = WshNetwork.AddWindowsPrinterConnection(PrinterPath)
If Not rc then
      WScript.Echo("Printer Connection Failed!")
End If
WshNetwork.SetDefaultPrinter PrinterPath