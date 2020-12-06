#requires -Version 3

param([string[]]$PreCacheList)

if (!(Test-Path variable:\helpCache) -or $RefreshCache) {
    $SCRIPT:helpCache = @{}
}    

function Resolve-MemberOwnerType
{
    [CmdletBinding()]
    param
    (
        [system.management.automation.psmethod]$method
    )

    # TODO: support overloads, support interface definitions

    $PSCmdlet.WriteVerbose("Resolving $($method.name)'s owning Type.")
   
    # hackety-hack - this is prone to breaking in the future
    $targetType = [system.management.automation.psmethod].getfield("baseObject", "Instance,NonPublic").getvalue($method)
    
    # [system.runtimetype] is special-cased in powershell - you can't reference it?
    if (-not ($targetType.GetType().fullname -eq "System.RuntimeType"))
    {
        $targetType = $targetType.GetType()
    }

    if ($method.OverloadDefinitions -match "static")
    {
        $flags = "Static,Public"
    }
    else
    {
        $flags = "Instance,Public"
    }

    # FIXME: support overloads    
    $methodInfo = $targetType.GetMethods($flags) | ?{$_.Name -eq $method.Name}| select -first 1
    
    if (-not $methodInfo)
    {
        # this shouldn't happen.
        throw "Could not resolve owning type!"
    }
    
    $declaringType = $methodInfo.DeclaringType
    
    $PSCmdlet.WriteVerbose("Owning Type is $($targetType.fullname). Method declared on $($declaringType.fullname).")

    $declaringType
}

function Get-DocsLocation
{
    [CmdletBinding()]
    param
    (
        [type]$type,
        
        [switch]$Online,
        
        [switch]$Members,
        
        [switch]$Static
    )
    
    # get documentation filename, assembly location and assembly codebase
    $docFilename = [io.path]::changeextension([io.path]::getfilename($type.assembly.location), ".xml")
    $location = [io.path]::getdirectoryname($type.assembly.location)
    $codebase = (new-object uri $type.assembly.codebase).localpath
    
    $PSCmdlet.WriteVerbose("Documentation file is $docFilename")
    
    if (-not $Online.IsPresent)
    {
        # try localized location (typically newer than base framework dir)
        $frameworkDir = "${env:windir}\Microsoft.NET\framework\v2.0.50727"
        $lang = [system.globalization.cultureinfo]::CurrentUICulture.parent.name

        # I love looking at this. A Duff's Device for PowerShell.. well, maybe not.
        switch
            (
            "${frameworkdir}\${lang}\$docFilename",
            "${frameworkdir}\$docFilename",
            "$location\$docFilename",
            "$codebase\$docFilename"
            )
        {
            { test-path $_ } { $_; return; }
            
            default
            {
                # try next path
                continue;
            }        
        }       
    }

    # failed to find local docs, is it from MS?
    if ((Get-ObjectVendor $type) -like "*Microsoft*")
    {
        # drop locale - site will redirect to correct variation based on browser accept-lang
        $suffix = ""
        if ($Members.IsPresent)
        {
            $suffix = "_members"
        }
        
        new-object uri ("http://msdn.microsoft.com/library/{0}{1}.aspx" -f $type.fullname,$suffix)
        
        return
    }
    
    $PSCmdlet.WriteWarning("Sorry, I couldn't find any local documentation for ${type}.")
}

# Dig out something that might lead us to the vendor of this Object
function Get-ObjectVendor
{
    [CmdletBinding()]
    param
    (
        [type]$type,
        [switch]$CompanyOnly
    )

    $assembly = $type.assembly
    $attrib = $assembly.GetCustomAttributes([Reflection.AssemblyCompanyAttribute], $false) | select -first 1        
    
    if ($attrib.Company)
    {
        # try company
        $attrib.Company
        return
    }
    else
    {
        if ($CompanyOnly) { return }
        
        # try copyright
        $attrib = $assembly.GetCustomAttributes([Reflection.AssemblyCopyrightAttribute], $false) | select -first 1
        
        if ($attrib.Copyright)
        {
            $attrib.Copyright
            return
        }
    }
    $PSCmdlet.WriteVerbose("Assembly has no [AssemblyCompany] or [AssemblyCopyright] attributes.")
}

function Get-HelpSummary
{
        [CmdletBinding()]
        param
        (        
            [string]$file,
            [reflection.assembly]$assembly,
            [string]$selector
        )
        
        if ($helpCache.ContainsKey($assembly))
        {            
            $xml = $helpCache[$assembly]
            
            $PSCmdlet.WriteVerbose("Docs were found in the cache.")
        }
        else
        {
            # cache it
            Write-Progress -id 1 "Caching Help Documentation" $assembly.getname().name

            # cache this for future lookups. It's a giant pig. Oink.
            $xml = [xml](gc $file)
            
            $helpCache.Add($assembly, $xml)
            
            Write-Progress -id 1 "Caching Help Documentation" $assembly.getname().name -completed
        }

        $PSCmdlet.WriteVerbose("Selector is $selector")        

        # TODO: support overloads
        $summary = $xml.doc.members.SelectSingleNode("member[@name='$selector' or starts-with(@name,'$selector(')]").summary
        
        $summary
}

function Show-Help
{
@"    
    
   
SYNTAX

$((get-help get-objecthelp).split([char]13) | % { "$_" })
"@
}

function Get-ObjectHelp
{    
    [CmdletBinding()]
    param
    (
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)]
        [ValidateNotNull()]
        $Object,

        [Parameter()]
        [switch]$Online,
        
        [Parameter()]
        [switch]$Member,
        
        [Parameter()]
        [switch]$Static
    )
    
    process 
    {
        if ($Object -is [string])
        {
            $PSCmdlet.WriteVerbose("A string was passed - reparsing as expression.")
            
            # they probably meant to pass the string inside '(' and ').'
            try
            {
                # e.g. "[int]::gettype" was passed without being wrapped
                # in new evaluative parentheses.
                $Object = invoke-expression $Object
            }
            catch
            {
                if ($_.fullyqualifiederrorid -eq "TypeNotFound,Microsoft.PowerShell.Commands.InvokeExpressionCommand")
                {
                    $PSCmdlet.WriteWarning("I don't recognize the Type in ${InputObject}. Are you sure you've typed it correctly?")
                }
                else
                {            
                    $PSCmdlet.WriteWarning("A string was passed and was parsed as an expression, and failed. " +
                        "If you really meant to find help on strings, pass [string] instead.")
                }
                $PSCmdlet.WriteVerbose($_)
                
                return
            }
        }

        $type = $Object.GetType()    
        $PSCmdlet.WriteVerbose("InputObject Type is $($type.Fullname)")
        
        $selector = $null
        
        # won't work with $type; case statements don't match with type literals?
        switch ($type.FullName)
        {
            "System.RuntimeType"
            {
                $PSCmdlet.WriteVerbose("[runtimetype]")
            
                $type = $Object
                $selector = "T:$($type.FullName)"
                
                break;
            }

            "System.Management.Automation.PSMethod"
            {
                $PSCmdlet.WriteVerbose("[psmethod]")
                
                $type = Resolve-MemberOwnerType $Object
                
                # TODO: support overloaded methods
                $selector = "M:$($type.FullName).$($Object.Name)"            
                
                break;
            }

            default
            {
                $PSCmdlet.WriteVerbose("[object]")
                $selector = "T:$($type.FullName)"            
            }
        }
        
        # do we have an assembly help xml somewhere?
        $docs = Get-DocsLocation $type -Online:$Online.IsPresent -Members:$Member.IsPresent -Static:$Static.IsPresent

        if ($docs)
        {
            $PSCmdlet.WriteVerbose("Found $docs")
            
            if ($docs -is [uri])
            {
                # Could not find local xml, but object is from Microsoft. Offer to view MSDN.
                $title = "Microsoft Developer Network"
                $message = "No local help for $($type.fullname).`n`nDo you want to visit this object's documentation page on MSDN?"
                $options = [System.Management.Automation.Host.ChoiceDescription[]]("&Yes", "&No")

                $result = $host.ui.PromptForChoice($title, $message, $options, 0)
                
                if ($result -eq 0) {
                    [diagnostics.process]::Start("iexplore.exe", $docs) > $null
                }
                return
            }
                    
            # get summary, if possible
            $summary = Get-HelpSummary $docs $type.assembly $selector
                    
            if ($summary)
            {
                [string]::empty
                
                # TODO: parse out <see ...> tags and create a PromptForChoice list to lookup referenced type(s).
                if ($summary.selectnodes) {
                    $see = $summary.selectnodes("see")
                }
                
                if (($Object -eq 42) -and (!$PSCmdlet.Force)) {
                
                    "What do you get if you multiply six by nine?"
                    [string]::empty
                    "That's it. That's all there is."
                
                } else {
                
                    $text = & {
                        if ($summary.innerxml) {
                            $summary.innerxml.trim()
                        }
                        else
                        {
                            $summary.trim()
                        }
                    }
                    
                    # strip <see ... /> tags
                    $text -replace [regex]'<see.*?"?:(.*?)"\s/>', '$1'
                }

                if ((Test-Path Variable:\see) -and $see) {
                    #Show-References 
                    # TODO: list of <see cref="foo" /> types
                }
                
                [string]::empty                
            }
            else
            {
                Write-Host "While some local documentation was found, it was incomplete. Sorry!"            
            }
        }
        else 
        {
            Write-Host "Sorry, I couldn't find any local documentation for ${type}."
            
            $vendor = Get-ObjectVendor $type -CompanyOnly
            
            if ($vendor)
            {
                # needed for urlencode
                add-type -a system.web

                write-host "However, it looks like the vendor of this Object is '${vendor}.'"
                
                $title = "Bing Search"
                $message = "Do you want to search for this object's documentation?"
                $options = [System.Management.Automation.Host.ChoiceDescription[]]("&Yes", "&No")

                $result = $host.ui.PromptForChoice($title, $message, $options, 0)
                
                if ($result -eq 0) {
                    # encode our question
                    $q = [system.web.httputility]::urlencode(("`"{0}`" {1}" -f $vendor, $type))
                    
                    # fire up the browser
                    [diagnostics.process]::Start("http://www.bing.com/results.aspx?q=$q")
                }
            }
        }
    }    
}

# cache common assembly help
function Preload-Documentation
{       
    if ($SCRIPT:helpCache.Keys.Count -eq 0) {
        # mscorlib
        $file = Get-DocsLocation ([int])
        Get-HelpSummary $file ([int].assembly) "T:System.Int32" > $null
        
        # system
        $file = Get-DocsLocation ([regex])    
        Get-HelpSummary $file ([regex].assembly) "T:System.Regex" > $null
    }
}

<#
.ForwardHelpTargetName Get-Help
.ForwardHelpCategory Cmdlet
#>
function Get-Help {
    # our proxy command generated from [proxycommand]::create((gcm get-help))
    [CmdletBinding(DefaultParameterSetName='AllUsersView', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113316')]
    param(
        [Parameter(Position=0, ValueFromPipelineByPropertyName=$true)]
        [System.String]
        ${Name},

        [System.String]
        ${Path},

        [System.String[]]
        ${Category},

        [System.String[]]
        ${Component},

        [System.String[]]
        ${Functionality},

        [System.String[]]
        ${Role},

        [Parameter(ParameterSetName='DetailedView', Mandatory=$true)]
        [Switch]
        ${Detailed},

        [Parameter(ParameterSetName='AllUsersView')]
        [Switch]
        ${Full},

        [Parameter(ParameterSetName='Examples', Mandatory=$true)]
        [Switch]
        ${Examples},

        [Parameter(ParameterSetName='Parameters', Mandatory=$true)]
        [System.String]
        ${Parameter},
        
        [Parameter(ParameterSetName='ObjectHelp', ValueFromPipeline = $true, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        ${Object},

        [Parameter(ParameterSetName='ObjectHelp')]
        [Switch]
        ${Member},
        
        [Parameter(ParameterSetName='ObjectHelp')]
        [Switch]
        ${Static},        

        [Parameter(ParameterSetName='ObjectHelp')]
        [Parameter(ParameterSetName='Online', Mandatory=$true)]
        [switch]
        ${Online},

        [Parameter(ParameterSetName='ShowWindow', Mandatory=$true)]
        [switch]
        ${ShowWindow}
    )

    begin
    {
        try 
        {
            if ($PSCmdlet.ParameterSetName -eq "ObjectHelp") 
            {                                
                Preload-Documentation
                
                $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Get-ObjectHelp', [System.Management.Automation.CommandTypes]::Function)
                $scriptCmd = { & $wrappedCmd @PSBoundParameters }
                $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)                
            } 
            else 
            {
				# Working around a bug in PowerShell (try man -?) where it passes in the wrong category info for aliases.
                if ($Name -ne $null)
                {
				    $commandInfo = try 
					{ 
						Microsoft.PowerShell.Core\Get-Command $Name -ErrorAction SilentlyContinue
					} 
					catch 
					{
						Write-Warning "Error calling Get-Command on ${Name}: $_"
					}
					if ($commandInfo -ne $null)
					{
						$isAlias = $commandInfo.CommandType -eq 'Alias'
						if ($isAlias)
						{
							$PSBoundParameters['Category'] = 'Alias'
						}
					}
                }

                $outBuffer = $null
                if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer) -and $outBuffer -gt 1024)
                {
                    $PSBoundParameters['OutBuffer'] = 1024
                }

                $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Get-Help', [System.Management.Automation.CommandTypes]::Cmdlet)
                $scriptCmd = { & $wrappedCmd @PSBoundParameters }
                $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)   
            }
            $steppablePipeline.Begin($PSCmdlet)
        } 
        catch {
            throw
        }
    }

    process
    {
        try {        
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }

    end
    {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }
}

Export-ModuleMember Get-Help

<#
    NAME
    
        ObjectHelp Extensions Module 0.3 for PowerShell 2.0
     
    SYNOPSIS
    
         Get-Help -Object allows you to display usage and summary help for .NET Types and Members.
         
    DETAILED DESCRIPTION
    
        Get-Help -Object allows you to display usage and summary help for .NET Types and Members.
    
        If local documentation is not found and the object vendor is Microsoft, you will be directed
        to MSDN online to the correct page. If the vendor is not Microsoft and vendor information
        exists on the owning assembly, you will be prompted to search for information using Bing.
     
    TODO
     
         * localize strings into PSD1 file
         * Implement caching in hashtables. XMLDocuments are fat pigs.
         * Support getting property/field help
         * PowerTab integration?
         * Test with Strict Parser
             
    EXAMPLES

        # get help on a type
        PS> get-help -obj [int]

        # get help against live instances
        PS> $obj = new-object system.xml.xmldocument
        PS> get-help -obj `$obj

        or even:
        
        PS> get-help -obj 42
        
        # get help against methods
        PS> get-help -obj `$obj.Load

        # explictly try msdn
        PS> get-help -obj [regex] -online

        # go to msdn for regex's members
        PS> get-help -obj [regex] -online -member
        
        # pipe support
        PS> 1,[int],[string]::format | get-help -verbose
    
    CREDITS
    
        Author: Oisin Grehan (MVP)
        Blog  : http://www.nivot.org/
    
        Have fun!    
#>

# SIG # Begin signature block
# MIIccgYJKoZIhvcNAQcCoIIcYzCCHF8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUYsPwtuIXOLoFTvYQ9YfX9J3L
# k6agghehMIIFKjCCBBKgAwIBAgIQBLQS3h09OUqqdSKUe3ftPjANBgkqhkiG9w0B
# AQsFADByMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
# VQQLExB3d3cuZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFz
# c3VyZWQgSUQgQ29kZSBTaWduaW5nIENBMB4XDTE2MTAxMjAwMDAwMFoXDTE5MTAx
# NzEyMDAwMFowZzELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNPMRUwEwYDVQQHEwxG
# b3J0IENvbGxpbnMxGTAXBgNVBAoTEDZMNiBTb2Z0d2FyZSBMTEMxGTAXBgNVBAMT
# EDZMNiBTb2Z0d2FyZSBMTEMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDDHT8E4dIiat1nGhayMJznISOTlfF48p2a7FNvIFG2ccoScZXJj53TmVkAF74J
# vFNld8ooNVig5BoqeO/Qq6MogKGLBl2gIaruHYwgll79z6aIsRJc6e9TjacIJZtr
# AUGGBg+5hl9fDygpfLQ3x0xEyTPbKcpDimc9MB5LSgclOwLXZflaEVqHvtHFDd3H
# FmuMtSS3ryhH8DrTglZNjYSbYTDBKVfq+J40Vzs5qhS86NiO2bZb+YVMQpDoZ6Yd
# EgXlOE6t4BHRoNX2r1VvnlUpwUnanRLkpGSq9nWmZF/YIUM13Zv7ceLwtnh8KrxI
# kaRr0kmYcJfv69kBI6e2Ezf5AgMBAAGjggHFMIIBwTAfBgNVHSMEGDAWgBRaxLl7
# KgqjpepxA8Bg+S32ZXUOWDAdBgNVHQ4EFgQU3UkpEeo3RgECtRdGHPkvZ6VK9PMw
# DgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMHcGA1UdHwRwMG4w
# NaAzoDGGL2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9zaGEyLWFzc3VyZWQtY3Mt
# ZzEuY3JsMDWgM6Axhi9odHRwOi8vY3JsNC5kaWdpY2VydC5jb20vc2hhMi1hc3N1
# cmVkLWNzLWcxLmNybDBMBgNVHSAERTBDMDcGCWCGSAGG/WwDATAqMCgGCCsGAQUF
# BwIBFhxodHRwczovL3d3dy5kaWdpY2VydC5jb20vQ1BTMAgGBmeBDAEEATCBhAYI
# KwYBBQUHAQEEeDB2MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5j
# b20wTgYIKwYBBQUHMAKGQmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdp
# Q2VydFNIQTJBc3N1cmVkSURDb2RlU2lnbmluZ0NBLmNydDAMBgNVHRMBAf8EAjAA
# MA0GCSqGSIb3DQEBCwUAA4IBAQB7bGUp27a8g3rslXsg8vJ5kSdoay0XAiJqRlZW
# J7yN89iw9Pf+KJaApRaGnG/DPpNz/KFDm3XOSeimCDAxWfJJiUjpClZGOA06BYUg
# +UmF1/3AuTkUaFPig5ZgwabS9Cc3JKg1ue6kHFYerTncA1Axcw/TkVemZayUdi1w
# gfMz01YYQ1Dr0LormXLC3br4kxlYY3vWmBMSgjYgiTNH+FkEMOcFEDFgGXLKUpyS
# tr2G+1UPgGhlNf4b/51Ul736M5L+tbkLYp4rO7WG5ojb+HOMHwEm/YiaK1V5QBii
# mQYYY7RQJ34sRORnWDH2MJbvrTNoQQoaDgT2u2bAaEc6RKYBMIIFMDCCBBigAwIB
# AgIQBAkYG1/Vu2Z1U0O1b5VQCDANBgkqhkiG9w0BAQsFADBlMQswCQYDVQQGEwJV
# UzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQu
# Y29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgQ0EwHhcNMTMx
# MDIyMTIwMDAwWhcNMjgxMDIyMTIwMDAwWjByMQswCQYDVQQGEwJVUzEVMBMGA1UE
# ChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMTEwLwYD
# VQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgQ29kZSBTaWduaW5nIENBMIIB
# IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA+NOzHH8OEa9ndwfTCzFJGc/Q
# +0WZsTrbRPV/5aid2zLXcep2nQUut4/6kkPApfmJ1DcZ17aq8JyGpdglrA55KDp+
# 6dFn08b7KSfH03sjlOSRI5aQd4L5oYQjZhJUM1B0sSgmuyRpwsJS8hRniolF1C2h
# o+mILCCVrhxKhwjfDPXiTWAYvqrEsq5wMWYzcT6scKKrzn/pfMuSoeU7MRzP6vIK
# 5Fe7SrXpdOYr/mzLfnQ5Ng2Q7+S1TqSp6moKq4TzrGdOtcT3jNEgJSPrCGQ+UpbB
# 8g8S9MWOD8Gi6CxR93O8vYWxYoNzQYIH5DiLanMg0A9kczyen6Yzqf0Z3yWT0QID
# AQABo4IBzTCCAckwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMweQYIKwYBBQUHAQEEbTBrMCQGCCsGAQUFBzAB
# hhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYBBQUHMAKGN2h0dHA6Ly9j
# YWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcnQw
# gYEGA1UdHwR6MHgwOqA4oDaGNGh0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9EaWdp
# Q2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2lj
# ZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwTwYDVR0gBEgwRjA4
# BgpghkgBhv1sAAIEMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0
# LmNvbS9DUFMwCgYIYIZIAYb9bAMwHQYDVR0OBBYEFFrEuXsqCqOl6nEDwGD5LfZl
# dQ5YMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6enIZ3zbcgPMA0GCSqGSIb3DQEB
# CwUAA4IBAQA+7A1aJLPzItEVyCx8JSl2qB1dHC06GsTvMGHXfgtg/cM9D8Svi/3v
# Kt8gVTew4fbRknUPUbRupY5a4l4kgU4QpO4/cY5jDhNLrddfRHnzNhQGivecRk5c
# /5CxGwcOkRX7uq+1UcKNJK4kxscnKqEpKBo6cSgCPC6Ro8AlEeKcFEehemhor5un
# XCBc2XGxDI+7qPjFEmifz0DLQESlE/DmZAwlCEIysjaKJAL+L3J+HNdJRZboWR3p
# +nRka7LrZkPas7CM1ekN3fYBIM6ZMWM9CBoYs4GbT8aTEAb8B4H6i9r5gkn3Ym6h
# U/oSlBiFLpKR6mhsRDKyZqHnGKSaZFHvMIIGajCCBVKgAwIBAgIQAwGaAjr/WLFr
# 1tXq5hfwZjANBgkqhkiG9w0BAQUFADBiMQswCQYDVQQGEwJVUzEVMBMGA1UEChMM
# RGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSEwHwYDVQQD
# ExhEaWdpQ2VydCBBc3N1cmVkIElEIENBLTEwHhcNMTQxMDIyMDAwMDAwWhcNMjQx
# MDIyMDAwMDAwWjBHMQswCQYDVQQGEwJVUzERMA8GA1UEChMIRGlnaUNlcnQxJTAj
# BgNVBAMTHERpZ2lDZXJ0IFRpbWVzdGFtcCBSZXNwb25kZXIwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQCjZF38fLPggjXg4PbGKuZJdTvMbuBTqZ8fZFnm
# fGt/a4ydVfiS457VWmNbAklQ2YPOb2bu3cuF6V+l+dSHdIhEOxnJ5fWRn8YUOawk
# 6qhLLJGJzF4o9GS2ULf1ErNzlgpno75hn67z/RJ4dQ6mWxT9RSOOhkRVfRiGBYxV
# h3lIRvfKDo2n3k5f4qi2LVkCYYhhchhoubh87ubnNC8xd4EwH7s2AY3vJ+P3mvBM
# MWSN4+v6GYeofs/sjAw2W3rBerh4x8kGLkYQyI3oBGDbvHN0+k7Y/qpA8bLOcEaD
# 6dpAoVk62RUJV5lWMJPzyWHM0AjMa+xiQpGsAsDvpPCJEY93AgMBAAGjggM1MIID
# MTAOBgNVHQ8BAf8EBAMCB4AwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggr
# BgEFBQcDCDCCAb8GA1UdIASCAbYwggGyMIIBoQYJYIZIAYb9bAcBMIIBkjAoBggr
# BgEFBQcCARYcaHR0cHM6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzCCAWQGCCsGAQUF
# BwICMIIBVh6CAVIAQQBuAHkAIAB1AHMAZQAgAG8AZgAgAHQAaABpAHMAIABDAGUA
# cgB0AGkAZgBpAGMAYQB0AGUAIABjAG8AbgBzAHQAaQB0AHUAdABlAHMAIABhAGMA
# YwBlAHAAdABhAG4AYwBlACAAbwBmACAAdABoAGUAIABEAGkAZwBpAEMAZQByAHQA
# IABDAFAALwBDAFAAUwAgAGEAbgBkACAAdABoAGUAIABSAGUAbAB5AGkAbgBnACAA
# UABhAHIAdAB5ACAAQQBnAHIAZQBlAG0AZQBuAHQAIAB3AGgAaQBjAGgAIABsAGkA
# bQBpAHQAIABsAGkAYQBiAGkAbABpAHQAeQAgAGEAbgBkACAAYQByAGUAIABpAG4A
# YwBvAHIAcABvAHIAYQB0AGUAZAAgAGgAZQByAGUAaQBuACAAYgB5ACAAcgBlAGYA
# ZQByAGUAbgBjAGUALjALBglghkgBhv1sAxUwHwYDVR0jBBgwFoAUFQASKxOYspkH
# 7R7for5XDStnAs0wHQYDVR0OBBYEFGFaTSS2STKdSip5GoNL9B6Jwcp9MH0GA1Ud
# HwR2MHQwOKA2oDSGMmh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFz
# c3VyZWRJRENBLTEuY3JsMDigNqA0hjJodHRwOi8vY3JsNC5kaWdpY2VydC5jb20v
# RGlnaUNlcnRBc3N1cmVkSURDQS0xLmNybDB3BggrBgEFBQcBAQRrMGkwJAYIKwYB
# BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBBBggrBgEFBQcwAoY1aHR0
# cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEQ0EtMS5j
# cnQwDQYJKoZIhvcNAQEFBQADggEBAJ0lfhszTbImgVybhs4jIA+Ah+WI//+x1Gos
# Me06FxlxF82pG7xaFjkAneNshORaQPveBgGMN/qbsZ0kfv4gpFetW7easGAm6mlX
# IV00Lx9xsIOUGQVrNZAQoHuXx/Y/5+IRQaa9YtnwJz04HShvOlIJ8OxwYtNiS7Dg
# c6aSwNOOMdgv420XEwbu5AO2FKvzj0OncZ0h3RTKFV2SQdr5D4HRmXQNJsQOfxu1
# 9aDxxncGKBXp2JPlVRbwuwqrHNtcSCdmyKOLChzlldquxC5ZoGHd2vNtomHpigtt
# 7BIYvfdVVEADkitrwlHCCkivsNRu4PQUCjob4489yq9qjXvc2EQwggbNMIIFtaAD
# AgECAhAG/fkDlgOt6gAK6z8nu7obMA0GCSqGSIb3DQEBBQUAMGUxCzAJBgNVBAYT
# AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
# dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0w
# NjExMTAwMDAwMDBaFw0yMTExMTAwMDAwMDBaMGIxCzAJBgNVBAYTAlVTMRUwEwYD
# VQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAf
# BgNVBAMTGERpZ2lDZXJ0IEFzc3VyZWQgSUQgQ0EtMTCCASIwDQYJKoZIhvcNAQEB
# BQADggEPADCCAQoCggEBAOiCLZn5ysJClaWAc0Bw0p5WVFypxNJBBo/JM/xNRZFc
# gZ/tLJz4FlnfnrUkFcKYubR3SdyJxArar8tea+2tsHEx6886QAxGTZPsi3o2CAOr
# DDT+GEmC/sfHMUiAfB6iD5IOUMnGh+s2P9gww/+m9/uizW9zI/6sVgWQ8DIhFonG
# cIj5BZd9o8dD3QLoOz3tsUGj7T++25VIxO4es/K8DCuZ0MZdEkKB4YNugnM/JksU
# kK5ZZgrEjb7SzgaurYRvSISbT0C58Uzyr5j79s5AXVz2qPEvr+yJIvJrGGWxwXOt
# 1/HYzx4KdFxCuGh+t9V3CidWfA9ipD8yFGCV/QcEogkCAwEAAaOCA3owggN2MA4G
# A1UdDwEB/wQEAwIBhjA7BgNVHSUENDAyBggrBgEFBQcDAQYIKwYBBQUHAwIGCCsG
# AQUFBwMDBggrBgEFBQcDBAYIKwYBBQUHAwgwggHSBgNVHSAEggHJMIIBxTCCAbQG
# CmCGSAGG/WwAAQQwggGkMDoGCCsGAQUFBwIBFi5odHRwOi8vd3d3LmRpZ2ljZXJ0
# LmNvbS9zc2wtY3BzLXJlcG9zaXRvcnkuaHRtMIIBZAYIKwYBBQUHAgIwggFWHoIB
# UgBBAG4AeQAgAHUAcwBlACAAbwBmACAAdABoAGkAcwAgAEMAZQByAHQAaQBmAGkA
# YwBhAHQAZQAgAGMAbwBuAHMAdABpAHQAdQB0AGUAcwAgAGEAYwBjAGUAcAB0AGEA
# bgBjAGUAIABvAGYAIAB0AGgAZQAgAEQAaQBnAGkAQwBlAHIAdAAgAEMAUAAvAEMA
# UABTACAAYQBuAGQAIAB0AGgAZQAgAFIAZQBsAHkAaQBuAGcAIABQAGEAcgB0AHkA
# IABBAGcAcgBlAGUAbQBlAG4AdAAgAHcAaABpAGMAaAAgAGwAaQBtAGkAdAAgAGwA
# aQBhAGIAaQBsAGkAdAB5ACAAYQBuAGQAIABhAHIAZQAgAGkAbgBjAG8AcgBwAG8A
# cgBhAHQAZQBkACAAaABlAHIAZQBpAG4AIABiAHkAIAByAGUAZgBlAHIAZQBuAGMA
# ZQAuMAsGCWCGSAGG/WwDFTASBgNVHRMBAf8ECDAGAQH/AgEAMHkGCCsGAQUFBwEB
# BG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMGCCsG
# AQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
# cmVkSURSb290Q0EuY3J0MIGBBgNVHR8EejB4MDqgOKA2hjRodHRwOi8vY3JsMy5k
# aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMDqgOKA2hjRo
# dHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0Eu
# Y3JsMB0GA1UdDgQWBBQVABIrE5iymQftHt+ivlcNK2cCzTAfBgNVHSMEGDAWgBRF
# 66Kv9JLLgjEtUYunpyGd823IDzANBgkqhkiG9w0BAQUFAAOCAQEARlA+ybcoJKc4
# HbZbKa9Sz1LpMUerVlx71Q0LQbPv7HUfdDjyslxhopyVw1Dkgrkj0bo6hnKtOHis
# dV0XFzRyR4WUVtHruzaEd8wkpfMEGVWp5+Pnq2LN+4stkMLA0rWUvV5PsQXSDj0a
# qRRbpoYxYqioM+SbOafE9c4deHaUJXPkKqvPnHZL7V/CSxbkS3BMAIke/MV5vEwS
# V/5f4R68Al2o/vsHOE8Nxl2RuQ9nRc3Wg+3nkg2NsWmMT/tZ4CMP0qquAHzunEIO
# z5HXJ7cW7g/DvXwKoO4sCFWFIrjrGBpN/CohrUkxg0eVd3HcsRtLSxwQnHcUwZ1P
# L1qVCCkQJjGCBDswggQ3AgEBMIGGMHIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxE
# aWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xMTAvBgNVBAMT
# KERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNpZ25pbmcgQ0ECEAS0Et4d
# PTlKqnUilHt37T4wCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKEC
# gAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwG
# CisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFLSvouEh1oKO7B7CITVurPFUJk3v
# MA0GCSqGSIb3DQEBAQUABIIBAMGNOkhx6lUSiRKt8FZZBOn1d13MoukaOHyuy+bf
# IoXbcMJcJPwrolUq/JOf8tP/3T3MHhvzK15Pzff9+N44NwGLhJ8qhiXd2d/YJTb9
# mIXV6Fpfp6shEeZfSLfjsn//tE08wGok3P9hBT4iCX5UV9TqHf68oZu+CxZRAAkH
# F0F8YVvN5CHQg3I/67LpoByanoXuI0HSe0qCjJMKJ+ihawBwLhsu+9E8dMpfYzlV
# Ms5d/eggsThHAR7NnF3SwRdSmG88+C23HmR9CsP0CvE/rn9xf5o9P/cxCfzM4W1i
# rNu2pmjt0qYdGYvOqgk9oR3XhzUJ/BhAWox6J6tDs1167U6hggIPMIICCwYJKoZI
# hvcNAQkGMYIB/DCCAfgCAQEwdjBiMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGln
# aUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSEwHwYDVQQDExhE
# aWdpQ2VydCBBc3N1cmVkIElEIENBLTECEAMBmgI6/1ixa9bV6uYX8GYwCQYFKw4D
# AhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
# DTE4MDExNzAyNDYzOFowIwYJKoZIhvcNAQkEMRYEFKUp8KSXE1Y9Dlnjz5HrF4Gb
# 8dy6MA0GCSqGSIb3DQEBAQUABIIBAC3uWoBJP4khC1Xm1wSMASHSXf+SmPbDQvqQ
# F9N8ze3u8MQbMomX48hhA+1Yvk7QAndJPQSlPbj1fhVvhmDYPT0P54NPrmUPP31O
# E2yFH9ywsVMnWZcq5Z0NjweThC07IPhjjXbkFzudbjRDH7EukQv4SafDhkl6PgCd
# usBpo9udxpVS+opsvbEeFGSengjSzT+AHX/Jv7nlrzCdons+nH1TdE+edovBmNGK
# ek3E3zdWDlPz5etu30X2g3v/kvOnklBV5bK5OB0bdX2mK/8Cmdp3BoGpF1xxM4YM
# s2KdiCbbql2+SoUqWA1RlshK9bpSpdX0oOTZZiv6sKmDOxIT0SA=
# SIG # End signature block
