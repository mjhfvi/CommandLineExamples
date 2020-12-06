@echo off


on error resume next

'== Set Sales Printer As default \\SERVER\SalesPrinterXerox

Set PrinterPath = "\\SERVER\SalesPrinterXerox"
Set WshNetwork = WScript.CreateObject("WScript.Network")
Set rc = WshNetwork.AddWindowsPrinterConnection(PrinterPath)
If Not rc then
      WScript.Echo("Printer Connection Failed!")
End If
WshNetwork.SetDefaultPrinter PrinterPath