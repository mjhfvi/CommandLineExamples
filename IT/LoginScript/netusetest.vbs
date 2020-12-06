If NOT objNetwork.Exists("\\SERVER\Software\Installations") Then
   Set objNetwork = CreateObject("WScript.Network")
   objNetwork.MapNetworkDrive "W:", "\\SERVER\Software\Installations"
End If