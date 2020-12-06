<#
.SYNOPSIS
Get Server Information
.DESCRIPTION
This script will get the CPU specifications, memory usage statistics, and OS configuration of any Server or Computer listed in Serverlist.txt.
.NOTES  
The script will execute the commands on multiple machines sequentially using non-concurrent sessions. This will process all servers from Serverlist.txt in the listed order.
The info will be exported to a csv format.
Requires: Serverlist.txt must be created in the same folder where the script is.
File Name  : get-server-info.ps1
Author: Nikolay Petkov
http://power-shell.com/
#>
#$Credential = Get-Credential
#Get the server list
$servers = Get-Content .\ComputerList.txt
#Run the commands for each server in the list
$infoColl = @()
Foreach ($s in $servers)
{
	$CPUInfo = Get-WmiObject Win32_Processor -ComputerName $s                                                                                              #Get CPU Information
	$OSInfo = Get-WmiObject Win32_OperatingSystem -ComputerName $s                                                                                         #Get OS Information
    $OSInfo2 = Get-WmiObject Win32_OperatingSystem -ComputerName $s 
    $InstalTime = Get-WmiObject -Class Win32_OperatingSystem -Computer $s
    $InstalledDate = $InstalTime.ConvertToDateTime($InstalTime.Installdate)         
    $BIOSInfo = Get-WmiObject Win32_BIOS -ComputerName $s                                                                                                  #Get BIOS Information
	#$ProductKey = Start PowerShell.exe Get-WindowsKey -ComputerName $s
    .\Get-ProductKey.ps1
    $WindowsKey = Get-ProductKey                                                                                                                           #run "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass" "Import-Module .\Get-ProductKey.ps1"
    $BIOSWindowsKey = Get-WmiObject -query ‘select * from SoftwareLicensingService'
    $ComputerInfo = Get-WmiObject Win32_ComputerSystem -ComputerName $s                                                                                    #Get Computer Information
    $USERInfo = Get-WMIObject -class Win32_ComputerSystem -ComputerName $s                                                                                 #Get User Information
    $DISKInfo = Get-WmiObject Win32_LogicalDisk -ComputerName $S                                                                                           #Get Disk Information
    foreach ($Disk in $DISKInfo)
    {
        $Disk.FreeSpace = [Math]::Round(($Disk.FreeSpace / 1GB), 2)                                                                                        #Get Disk Information, The data will be shown in a table as MB, rounded to the nearest second decimal.
    }
    $DISKType = Get-WmiObject win32_diskdrive
    foreach ($Disk in $DISKInfo) 
    { 
        $Disk.model -match "SSD"                                                                                                                           #Get DIsk Type Information
    }
    $PhysicalMemory = Get-WmiObject CIM_PhysicalMemory -ComputerName $s | Measure-Object -Property capacity -Sum | % { [Math]::Round(($_.sum / 1GB), 2) }  #Get Memory Information, The data will be shown in a table as MB, rounded to the nearest second decimal.
	#$OSTotalVirtualMemory = [math]::round($OSInfo.TotalVirtualMemorySize / 1MB, 2)                                                                        #Get Memory Information, The data will be shown in a table as MB, rounded to the nearest second decimal.
	$OSTotalVisibleMemory = [math]::round(($OSInfo.TotalVisibleMemorySize / 1MB), 2)                                                                       #Get Memory Information, The data will be shown in a table as MB, rounded to the nearest second decimal.
    $IPconfig = Get-WmiObject Win32_NetworkAdapterConfiguration -ComputerName $s | Select IPAddress | Where-Object {$_.IPaddress -like "1*"}               #Get IP Address Information
    #$IPAddress = Get-WmiObject -Class Win32_NetworkAdapter                                                                                                #Get NIC information ##NOT WORKING
    foreach ($NICSpeed in $IPAddress) 
    {
        $NICSpeed.Speed = [Math]::Round(($NICSpeed.Speed / 1GB), 2)                                                                                        #Get Disk Information, The data will be shown in a table as MB, rounded to the nearest second decimal.
    } 
    #$SoftwareInfo = Get-WmiObject -Class win32_product -ComputerName $S -Filter "Name like '%office%'"                                                    #Get Software Information
	Foreach ($CPU in $CPUInfo)
	{
		$infoObject = New-Object PSObject
		#The following add data to the infoObjects.	
		Add-Member -inputObject $infoObject -memberType NoteProperty -name "Computer Name" -value $CPU.SystemName
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "Windows Product Key" -value $WindowsKey.ProductKey
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "BIOS Windows Product Key" -value $BIOSWindowsKey.OA3xOriginalProductKey
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "Windows Install date" -value $InstalledDate
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "Logged In User" -value $USERInfo.username
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "Computer Model" -value $ComputerInfo.Model
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "OS Name" -value $OSInfo.Caption
		Add-Member -inputObject $infoObject -memberType NoteProperty -name "OS Version" -value $OSInfo.Version
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "BIOS Serial Number" -value $BIOSInfo.SerialNumber
		#Add-Member -inputObject $infoObject -memberType NoteProperty -name "Processor_Type" -value $CPU.Name
		Add-Member -inputObject $infoObject -memberType NoteProperty -name "Processor Model" -value $CPU.Description
        #Add-Member -inputObject $infoObject -memberType NoteProperty -name "Processor_Id" -value $CPU.ProcessorId
		#Add-Member -inputObject $infoObject -memberType NoteProperty -name "Manufacturer" -value $CPU.Manufacturer
		Add-Member -inputObject $infoObject -memberType NoteProperty -name "Physical Cores" -value $CPU.NumberOfCores
		#Add-Member -inputObject $infoObject -memberType NoteProperty -name "CPU_L2CacheSize" -value $CPU.L2CacheSize
		#Add-Member -inputObject $infoObject -memberType NoteProperty -name "CPU_L3CacheSize" -value $CPU.L3CacheSize
		#Add-Member -inputObject $infoObject -memberType NoteProperty -name "Sockets" -value $CPU.SocketDesignation
		Add-Member -inputObject $infoObject -memberType NoteProperty -name "Logical Cores" -value $CPU.NumberOfLogicalProcessors
		Add-Member -inputObject $infoObject -memberType NoteProperty -name "Total Physical Memory_GB" -value $OSTotalVisibleMemory
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "Memory Speed" -value $PhysicalMemoryInfo.Speed
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "Memory Banks" -value $PhysicalMemoryInfo.banklabel
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "Partition ID" -value $DISKInfo.DeviceID
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "Partition Free Space" -value $DISKInfo.freespace
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "Partition SSD" -value $DISKType.Model
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "IP Address/MAC" -value $IPconfig.IPAddress
        #Add-Member -inputObject $infoObject -memberType NoteProperty -name "IP Address Speed" -value $IPAddress.Speed
        #Add-Member -inputObject $infoObject -memberType NoteProperty -name "Softwares Name" -value $SoftwareInfo.Name
        #Add-Member -inputObject $infoObject -memberType NoteProperty -name "Softwares Version" -value $SoftwareInfo.Version
		$infoObject                                                                                                                                          #Output to the screen for a visual feedback.
		#$infoColl += $infoObject
	}
}
$infoColl | Export-Csv -path .\Server_Inventory_$((Get-Date).ToString('MM-dd-yyyy')).csv -NoTypeInformation                                                  #Export the results in csv file.