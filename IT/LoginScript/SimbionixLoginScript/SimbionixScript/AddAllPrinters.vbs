'@echo off


on error resume next

   Dim net
   
'== Add Main Printer
   Set net = CreateObject("WScript.Network")    
   net.AddWindowsPrinterConnection "\\SERVER\MainPrinterXerox"  

'== Add Sales Printer
   Set net = CreateObject("WScript.Network")    
   net.AddWindowsPrinterConnection "\\SERVER\SalesPrinterXerox"