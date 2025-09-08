function Read-PPHost {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        $Message
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Host "[?] $Message" -ForegroundColor Blue -BackgroundColor DarkGray
        Read-Host "> "
    }
}

function Send-PPFunctionToRemote {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
        https://matthewjdegarmo.com/powershell/2021/03/31/how-to-import-a-locally-defined-function-into-a-remote-powershell-session.html
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$FunctionName,
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$Session
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $FunctionName | ForEach-Object {
            try {
                $Function = Get-Command -Name $_
                if ($Function) {
                    $Definition = @"
$($Function.CommandType) $_ {
$($Function.Definition)
}
"@                  
                    Invoke-Command -Session $Session -ScriptBlock {
                        param($LoadMe)
                        . ([scriptblock]::Create($LoadMe))
                    } -ArgumentList $Definition
                }
            }
            catch {
                throw $_
            }
        }
    }
    
    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Show-PPLogo {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    param(
        [string]$Version
    )

    # Write-Host '' -BackgroundColor Black -ForegroundColor Red -NoNewline
    # Write-Host '' -BackgroundColor Black -ForegroundColor DarkYellow -NoNewline
    # Write-Host '' -BackgroundColor Black -ForegroundColor Yellow -NoNewline
    # Write-Host '' -BackgroundColor Black -ForegroundColor Green -NoNewline
    # Write-Host '' -BackgroundColor Black -ForegroundColor DarkGreen -NoNewline
    # Write-Host '' -BackgroundColor Black -ForegroundColor Blue -NoNewline
    # Write-Host '' -BackgroundColor Black -ForegroundColor DarkBlue -NoNewline
    # Write-Host '' -BackgroundColor Black -ForegroundColor Magenta -NoNewline
    # Write-Host '' -BackgroundColor Black -ForegroundColor DarkMagenta -NoNewline
    # Write-Host

    Write-Host '                                                                '

    Write-Host '  ______ ' -BackgroundColor Black -ForegroundColor Red -NoNewline
    Write-Host '       ' -BackgroundColor Black -ForegroundColor DarkYellow -NoNewline
    Write-Host '         ' -BackgroundColor Black -ForegroundColor Yellow -NoNewline
    Write-Host '      ' -BackgroundColor Black -ForegroundColor Green -NoNewline
    Write-Host '     ' -BackgroundColor Black -ForegroundColor DarkGreen -NoNewline
    Write-Host ' ______ ' -BackgroundColor Black -ForegroundColor Blue -NoNewline
    Write-Host '_______ ' -BackgroundColor Black -ForegroundColor DarkBlue -NoNewline
    Write-Host '_______ ' -BackgroundColor Black -ForegroundColor Magenta -NoNewline
    Write-Host '__  ' -BackgroundColor Black -ForegroundColor DarkMagenta -NoNewline
    Write-Host
    
    Write-Host ' |   __ \' -BackgroundColor Black -ForegroundColor Red -NoNewline
    Write-Host '.-----.' -BackgroundColor Black -ForegroundColor DarkYellow -NoNewline
    Write-Host '--.--.--.' -BackgroundColor Black -ForegroundColor Yellow -NoNewline
    Write-Host '-----.' -BackgroundColor Black -ForegroundColor Green -NoNewline
    Write-Host '----.' -BackgroundColor Black -ForegroundColor DarkGreen -NoNewline
    Write-Host '|   __ \' -BackgroundColor Black -ForegroundColor Blue -NoNewline
    Write-Host '   |   |' -BackgroundColor Black -ForegroundColor DarkBlue -NoNewline
    Write-Host '     __|' -BackgroundColor Black -ForegroundColor Magenta -NoNewline
    Write-Host '  | ' -BackgroundColor Black -ForegroundColor DarkMagenta -NoNewline
    Write-Host

    Write-Host ' |    __/' -BackgroundColor Black -ForegroundColor Red -NoNewline
    Write-Host '|  _  |' -BackgroundColor Black -ForegroundColor DarkYellow -NoNewline
    Write-Host '  |  |  |' -BackgroundColor Black -ForegroundColor Yellow -NoNewline
    Write-Host '  -__|' -BackgroundColor Black -ForegroundColor Green -NoNewline
    Write-Host '   _|' -BackgroundColor Black -ForegroundColor DarkGreen -NoNewline
    Write-Host '|    __/' -BackgroundColor Black -ForegroundColor Blue -NoNewline
    Write-Host '   |   |' -BackgroundColor Black -ForegroundColor DarkBlue -NoNewline
    Write-Host '    |  |' -BackgroundColor Black -ForegroundColor Magenta -NoNewline
    Write-Host '__| ' -BackgroundColor Black -ForegroundColor DarkMagenta -NoNewline
    Write-Host

    Write-Host ' |___|   ' -BackgroundColor Black -ForegroundColor Red -NoNewline
    Write-Host '|_____|' -BackgroundColor Black -ForegroundColor DarkYellow -NoNewline
    Write-Host '________|' -BackgroundColor Black -ForegroundColor Yellow -NoNewline
    Write-Host '_____|' -BackgroundColor Black -ForegroundColor Green -NoNewline
    Write-Host '__|  ' -BackgroundColor Black -ForegroundColor DarkGreen -NoNewline
    Write-Host '|___|  ' -BackgroundColor Black -ForegroundColor Blue -NoNewline
    Write-Host '|_______|' -BackgroundColor Black -ForegroundColor DarkBlue -NoNewline
    Write-Host '_______|' -BackgroundColor Black -ForegroundColor Magenta -NoNewline
    Write-Host '__| ' -BackgroundColor Black -ForegroundColor DarkMagenta -NoNewline
    Write-Host
    Write-Host "                                    v2025.7.22    " -BackgroundColor Black -ForegroundColor Magenta
    Write-Host '                                                        ' -BackgroundColor Black
}
function Show-PPOutro {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    param(
        [string]$Version
    )

    Read-Host 'Press Enter to Continue'
    Write-Host @"
     @@@@@@@@@@@@@@@@@@@@                                     @@@@@@@@@@@@@@@@@@@  
    @@@@@@@@@@@@@@@@@@@&                                       @@@@@@@@@@@@@@@@@@@
   @@@@@@@@@@@@@@@@@@                                            %@@@@@@@@@@@@@@@@@
   @@@@@@@@@@@@@@@@                                                 @@@@@@@@@@@@@@@
   @@@@@@@@@@@@@                                                      %@@@@@@@@@@@@
   @@@@@@@@@@@         https://github.com/jakehildreth/PowerPUG           @@@@@@@@@@
   @@@@@@@@                                                                @@@@@@@@
   @@@@@@                                                                     @@@@@
   @@@           %@@@                                       @@@@                @@@
                @@@@@                  @@@@@@@@#           @@@@(                   
                @@@@@@.   ,@        @@@@@@@@@@@@@@        #@@@@@@    @@            
                *@@@@@@@@@@,      @@@@@@@@@@@@@@@@@@@      @@@@@@@@@@@             
                   @@@@@@      %@@@@@             @@@@@       @@@@@#               
                             @@@@@@@@,           @@@@@@@@@                         
                          (@@@@@@@@@@@@@      (@@@@@@@@@@@@@                       
                        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%                    
                     (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                  
                   @@@@@@@@@@@@@@@@@@@@@@@@.@@@@@@@@@@@@@@@@@@@@@@@&               
                 @@@@@@@@@@@@@@@@@@@@@           @@@@@@@@@@@@@@@@@@@@,             
                @@@@@@@@@@@@@@@@@@@                 @@@@@@@@@@@@@@@@@@             
                *@@@@@@@@@@@@@@@@@@@.             @@@@@@@@@@@@@@@@@@@@             
                 #@@@@@@@@@@@@@@@@@@@@@,       @@@@@@@@@@@@@@@@@@@@@@              
                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
"@ -ForegroundColor Magenta
}
function Test-PPIsDc {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
    )

    #requires -Version 5

    begin {
    }

    process {
    }

    end {
        if (Get-CimInstance -Class CIM_OperatingSystem | Where-Object ProductType -EQ 2) {
            Write-Output $true
        }
        else {
            Write-Output $false
        }
    }
}

function Test-PPIsElevated {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
    )

    #requires -Version 5

    begin {
    }

    process {
    }

    end {
        ([Security.Principal.WindowsPrincipal]::New([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    }
}

function Write-PPHost {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [ValidateSet('Info', 'Warning', 'Success', 'Error', 'Code', 'Remediation', 'Title', 'Subtitle')]
        $Type,
        [Parameter(Mandatory, Position = 1)]
        $Message
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $ForegroundColor = $Host.UI.RawUI.ForegroundColor
        $BackgroundColor = $Host.UI.RawUI.BackgroundColor
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Status = switch ($Type) {
            'Info' {
                @{
                    Decoration      = 'i'
                    ForegroundColor = 'Cyan'
                    BackgroundColor = $BackgroundColor
                }
            }
            'Warning' {
                @{
                    Decoration      = '!'
                    ForegroundColor = 'DarkYellow'
                    BackgroundColor = $BackgroundColor
                }
            }
            'Success' {
                @{
                    Decoration      = '+'
                    ForegroundColor = 'Green'
                    BackgroundColor = $BackgroundColor
                }
            }
            'Error' {
                @{
                    Decoration      = 'X'
                    ForegroundColor = 'Red'
                    BackgroundColor = $BackgroundColor
                }
            }
            'Code' {
                @{
                    Decoration      = '>'
                    ForegroundColor = 'Black'
                    BackgroundColor = 'DarkGray'
                }
            }
            'Remediation' {
                @{
                    Decoration      = '~'
                    ForegroundColor = 'DarkCyan'
                    BackgroundColor = 'Gray'
                }
            }
            'Title' {
                @{
                    Decoration      = '>'
                    ForegroundColor = 'White'
                    BackgroundColor = $BackgroundColor
                }
            }
            'Subtitle' {
                @{
                    Decoration      = '>'
                    ForegroundColor = 'DarkGray'
                    BackgroundColor = $BackgroundColor
                }
            }
        }

        if ($VerbosePreference -eq 'Continue') {
            $Decorator = "[$($Status.Decoration)]      [$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')]"
        }
        else {
            $Decorator = "[$($Status.Decoration)]"
        }

        Write-Host "$Decorator $Message" -ForegroundColor $Status.ForegroundColor -BackgroundColor $Status.BackgroundColor -NoNewline
        Write-Host -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor
    }
}

function Get-PPDC {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $Domain) {
            $Domain = Get-PPDomain
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Domain | ForEach-Object {
            $DirectoryContext = [System.DirectoryServices.ActiveDirectory.DirectoryContext]::New(0, $_.Name)
            [System.DirectoryServices.ActiveDirectory.DomainController]::FindAll($DirectoryContext) | ForEach-Object {
                if ($_.Forest -and $_.Domain) {
                    Write-Output $_
                }
                else {
                    Write-PPHost -Type Warning -Message "$($_.Name) is not reachable. PowerPUG! will not attempt to analyze it for PUG readiness."
                }
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Get-PPDCAuditPolicy {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet(
            'Account Logon',
            'Account Management',
            'Detailed Tracking',
            'DS Access',
            'Logon/Logoff',
            'Object Access',
            'Policy Change',
            'Privilege Use',
            'System'
        )]
        [string[]]$Category = 'Logon/Logoff'
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $CsvTemp = New-TemporaryFile
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Output $Category -PipelineVariable cat | ForEach-Object {
            auditpol /get /category:$_ /r | Out-File $CsvTemp -Force
            $Auditpol = Import-Csv -Path $CsvTemp
            $Auditpol | ForEach-Object {
                $_ | Add-Member -NotePropertyName Category -NotePropertyValue $cat -Force
                Write-Output $_
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Remove-Item $CsvTemp
    }
}

function Get-PPDCLogConfiguration {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$DC
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $DC) {
            $DC = Get-PPDC
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Output $DC -PipelineVariable domaincontroller | ForEach-Object {
            try {
                $Session = New-PSSession -ComputerName $domaincontroller -ErrorAction Stop
                Send-PPFunctionToRemote -FunctionName Get-PPDCAuditPolicy -Session $Session
                Write-PPHost -Type Info -Message "Checking if $($_.Name) has Logon Auditing enabled."
                Invoke-Command -Session $Session -ScriptBlock { Get-PPDCAuditPolicy }
            }
            catch {
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }
}
function Get-PPDCNtlmLogon {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$DC
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $DC) {
            $DC = Get-PPDC
        }
    }

    process {
        $DC | ForEach-Object {
            Write-PPHost -Type Info -Message "Gathering NTLM logon events from $($_.Name)."
            Invoke-Command -ComputerName $_ {
                $NtlmFilter = @"
                    *[EventData
                        [Data[@Name='AuthenticationPackageName']
                        and (Data='NTLM')]
                    ]
                    [System
                        [(EventID=4624)]
                    ]
"@
                $Query = [System.Diagnostics.Eventing.Reader.EventLogQuery]::New('Security', 'LogName', $NtlmFilter)
                $Reader = [System.Diagnostics.Eventing.Reader.EventLogReader]::New($Query) 
                try {
                    while ($true) {
                        $NtlmEvent = $Reader.ReadEvent()
                        $Message = $NtlmEvent.FormatDescription()
                        $NtlmEvent | Add-Member -NotePropertyName Message -NotePropertyValue $Message -Force
                        $NtlmEvent
                    }
                }
                catch {
                    Out-Null
                }
            }
        }
    }

    end {
    }
}

function Get-PPDCWeakKerberosLogon {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$DC
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $DC) {
            $DC = Get-PPDC
        }
    }

    process {
        $DC | ForEach-Object {
            Write-PPHost -Type Info -Message "Gathering Weak Kerberos usage events from $($_.Name)."
            Invoke-Command -ComputerName $_ {
                $KerberosFilter = @"
                    *[EventData
                        [Data[@Name='TicketEncryptionType']!='0x12']
                        [Data[@Name='TicketEncryptionType']!='0x11']
                        [Data[@Name='TicketEncryptionType']!='0xFFFFFFFF']
                    ]
                    [System
                        [(EventID=4768)]
                    ]
"@
                $Query = [System.Diagnostics.Eventing.Reader.EventLogQuery]::New('Security', 'LogName', $KerberosFilter)
                $Reader = [System.Diagnostics.Eventing.Reader.EventLogReader]::New($Query) 
                try {
                    while ($true) {
                        $KerberosEvent = $Reader.ReadEvent()
                        $Message = $KerberosEvent.FormatDescription()
                        $KerberosEvent | Add-Member -NotePropertyName Message -NotePropertyValue $Message -Force
                        $KerberosEvent
                    }
                }
                catch {
                    Out-Null
                }
            }
        }
    }

    end {
    }
}

function Test-PPDCLogConfiguration {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$Configuration
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Configuration | ForEach-Object {
            if ( ($_.'Policy Target' -eq 'System') -and ($_.Category -eq 'Logon/Logoff') -and 
                ($_.Subcategory -eq 'Logon') -and ($_.'Inclusion Setting' -eq 'Success and Failure')
            ) {
                Write-Output $true
            }
            elseif ( ($_.'Policy Target' -eq 'System') -and ($_.Category -eq 'Logon/Logoff') -and 
                ($_.Subcategory -eq 'Logon') -and ($_.'Inclusion Setting' -ne 'Success and Failure')
            ) {
                Write-Output $false
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }
}

function Test-PPDCOS {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$DC
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $DcOsWithPugArray = @(
            'Windows Server 2025 Standard',
            'Windows Server 2025 Datacenter',
            'Windows Server 2022 Standard',
            'Windows Server 2022 Datacenter',
            'Windows Server 2019 Standard',
            'Windows Server 2019 Datacenter',
            'Windows Server 2016 Standard',
            'Windows Server 2016 Datacenter',
            'Windows Server 2012 R2 Standard',
            'Windows Server 2012 R2 Datacenter'
        )
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $DC | ForEach-Object {
            if ($DcOsWithPugArray -contains $_.OSVersion.ToString()) {
                Write-Output $true
            }
            else {
                Write-Output $false
            }
        }
    }
    
    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Test-PPDCRemotingEnabled {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$DC
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $DC | ForEach-Object {
            Write-PPHost -Type Info -Message "Checking if $($_.Name) has PowerShell Remoting enabled."
            Test-WSMan -ComputerName $_ -ErrorAction SilentlyContinue
            $?
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }
}

function Get-PPDomain {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Forest
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $Forest) {
            $Forest = Get-PPForest
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..." 
        $Forest.Domains | ForEach-Object {
            if ( $_.Forest -and ($null -ne $_.DomainControllers) -and ($_.DomainControllers -ne '')) {
                Write-Output $_
            }
            else {
                Write-PPHost -Type Warning -Message "$($_.Name) is not reachable. PowerPUG! will not attempt to analyze it for PUG readiness."
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Get-PPDomainAdminGroupSid {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $Domain) {
            $Domain = Get-PPDomain
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Output $Domain -PipelineVariable loopdomain | ForEach-Object {
            if (-not $Domain.Sid) {
                $DomainSid = Get-PPDomainSid -Domain $loopdomain
            }
            else {
                $DomainSid = $Domain.Sid
            }
            @('S-1-5-32-544', "$DomainSid-512") | ForEach-Object {
                $AdaGroupSid = [System.Security.Principal.SecurityIdentifier]::New($_)
                $AdaGroupSid | Add-Member -NotePropertyName Domain -NotePropertyValue $loopdomain -Force
                Write-Output $AdaGroupSid
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Get-PPDomainKrbtgt {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
        if ($null -eq $Domain) {
            $Domain = Get-PPDomain
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Domain | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain', $_.Name)
            if (-not $Domain.Sid) {
                $DomainSid = Get-PPDomainSid -Domain $_
            }
            else {
                $DomainSid = $Domain.Sid
            }
            $KrbtgtSid = [System.Security.Principal.SecurityIdentifier]::New("$DomainSid-502")
            [System.DirectoryServices.AccountManagement.UserPrincipal]::FindByIdentity($PrincipalContext, $KrbtgtSid)
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Get-PPDomainPugCreatedDate {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    # TODO Investigate changing this to RODC group since it was created w/upgrade to 2008.
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
        if ($null -eq $Domain) {
            $Domain = Get-PPDomain
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Domain | Where-Object PugExists | ForEach-Object {
            if (-not $_.PugSid) {
                $PugSid = Get-PPDomainPugSid -Domain $_
            }
            else {
                $PugSid = $_.PugSid
            }
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain', $_.Name)
            $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext, $PugSid)
            $GroupPrincipal.GetUnderlyingObject().Properties["whenCreated"]
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Get-PPDomainPugSid {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $Domain) {
            $Domain = Get-PPDomain
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Output $Domain -PipelineVariable loopdomain | ForEach-Object {
            if (-not $Domain.Sid) {
                $DomainSid = Get-PPDomainSid -Domain $_
            }
            else {
                $DomainSid = $Domain.Sid
            }
            @("$DomainSid-525") | ForEach-Object {
                $GroupSid = [System.Security.Principal.SecurityIdentifier]::New($_)
                $GroupSid | Add-Member -NotePropertyName Domain -NotePropertyValue $loopdomain -Force
                Write-Output $GroupSid
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Get-PPDomainSid {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    # TODO this is hacky. Replace krbtgt SID with the PDCe SID instead.
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $Domain) {
            $Domain = Get-PPDomain
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Domain | Where-Object { $_.Forest -and $_.DomainControllers } | ForEach-Object {
            $DomainKrbtgtSid = [System.Security.Principal.NTAccount]::New($_.Name, 'krbtgt').Translate([System.Security.Principal.SecurityIdentifier]).Value 
            $DomainSid = [System.Security.Principal.SecurityIdentifier]::New($DomainKrbtgtSid.Substring(0, $DomainKrbtgtSid.length - 4))
            $DomainSid | Add-Member -NotePropertyName Domain -NotePropertyValue $_ -Force
            Write-Output $DomainSid
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Test-PPDomainFL {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }
    
    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Domain | ForEach-Object {
            if ($_.DomainModeLevel -ge 6) {
                Write-Output $true 
            }
            else {
                Write-Output $false
            }
        }
    }

    end {
    }
}

function Test-PPDomainPugExists {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Domain | ForEach-Object {
            $PugExists = $false
            if (-not $_.PugSid) {
                $PugSid = Get-PPDomainPugSid -Domain $_
            }
            else {
                $PugSid = $_.PugSid
            }
            try {
                $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain', $_)
                $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext, $PugSid)
                $GroupPrincipal.GetMembers() | Out-Null
                $PugExists = $true
            }
            catch {
            }

            Write-Output $PugExists
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Get-PPEnvironment {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Paramter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
    )

    #requires -Version 5

    #region collection and enrichment
    #region collect forest environmental info
    Write-PPHost -Type Info -Message "Collecting Forest Information"
    $Forest = Get-PPForest
    Write-PPHost -Type Info -Message "Enriching Collected Forest Information"
    $Forest | ForEach-Object {
        $PugFFL = Test-PPForestFL -Forest $_
        $_ | Add-Member -NotePropertyName PugFFL -NotePropertyValue $PugFFL -Force
        $ForestAdminGroupSids = Get-PPForestAdminGroupSid -Forest $_
        $_ | Add-Member -NotePropertyName AdminGroupSids -NotePropertyValue $ForestAdminGroupSids -Force
    }

    #endregion collect forest enviromental info
    
    #region collect domain environmental info
    Write-PPHost -Type Info -Message "Collecting Domain Information"
    $Domains = Get-PPDomain -Forest $Forest | Select-Object -Unique
    Write-PPHost -Type Info -Message "Enriching Collected Domain Information"
    $Domains | ForEach-Object {
        $DomainSid = Get-PPDomainSid -Domain $_
        $_ | Add-Member -NotePropertyName Sid -NotePropertyValue $DomainSid -Force
        $PugDFL = Test-PPDomainFL -Domain $_
        $_ | Add-Member -NotePropertyName PugDFL -NotePropertyValue $PugDFL -Force
        $PugSid = Get-PPDomainPugSid -Domain $_
        $_ | Add-Member -NotePropertyName PugSid -NotePropertyValue $PugSid -Force
        $PugExists = Test-PPDomainPugExists -Domain $_
        $_ | Add-Member -NotePropertyName PugExists -NotePropertyValue $PugExists -Force
        $DomainAdminGroupSids = Get-PPDomainAdminGroupSid -Domain $_
        $_ | Add-Member -NotePropertyName AdminGroupSids -NotePropertyValue $DomainAdminGroupSids -Force
    }
    #endregion collect forest environmental info

    #region collect domain controller environmental info
    Write-PPHost -Type Info -Message "Collecting Domain Controller Information"
    $Dcs = Get-PPDC -Domain $Domains | Select-Object -Unique
    Write-PPHost -Type Info -Message "Enriching Collected Domain Controller Information"
    $Dcs | ForEach-Object {
        $PugOS = Test-PPDCOS -DC $_
        $_ | Add-Member -NotePropertyName PugOS -NotePropertyValue $PugOS -Force
        $RemotingEnabled = Test-PPDCRemotingEnabled -DC $_
        $_ | Add-Member -NotePropertyName RemotingEnabled -NotePropertyValue $RemotingEnabled -Force
        if ($_.RemotingEnabled) {
            try {
                $AuditingConfiguration = Get-PPDCLogConfiguration -DC $_
                $AuditingEnabled = Test-PPDCLogConfiguration -Configuration $AuditingConfiguration
            }
            catch {
                $AuditingEnabled = $false
            }
            $_ | Add-Member -NotePropertyName AuditingEnabled -NotePropertyValue $AuditingEnabled -Force
            if ($_.AuditingEnabled) {
                $NtlmLogons = Get-PPDCNtlmLogon -DC $_
                $_ | Add-Member -NotePropertyName NtlmLogons -NotePropertyValue $NtlmLogons -Force
                $WeakKerberosLogons = Get-PPDCWeakKerberosLogon -DC $_
                $_ | Add-Member -NotePropertyName WeakKerberosLogons -NotePropertyValue $WeakKerberosLogons -Force
            }
            else {
                Write-PPHost -Type Warning -Message "Logon auditing is not enabled on $($_.Name). PowerPUG! will not attempt to check it for weak authentication."
            }
        }
        else {
            $_ | Add-Member -NotePropertyName AuditingEnabled -NotePropertyValue $false -Force
            Write-PPHost -Type Warning -Message "Remoting is disabled on $($_.Name). PowerPUG! will not attempt to check it for weak authentication."
        }
    }
    # Needed during weak logon checks
    $DcsWithAuditingEnabled = $Dcs | Where-Object { $_.AuditingEnabled -eq $true }
    #endregion collect domain controller environmental info

    #region expand group membership
    Write-PPHost -Type Info -Message "Collecting Protected User Group Membership"
    $PugMembers = Expand-PPGroupMembership -Sid $Domains.PugSid

    Write-PPHost -Type Info -Message "Collecting Forest AD Admin Group Membership"
    $ForestAdmins = Expand-PPGroupMembership -Sid $Forest.AdminGroupSids | Select-Object -Unique
    Write-PPHost -Type Info -Message "Enriching Collected AD Forest Admin Information"
    $ForestAdmins | ForEach-Object {
        $PugMember = Test-PPUserPugMember -User $_ -PugMembership $PugMembers
        $_ | Add-Member -NotePropertyName PugMember -NotePropertyValue $PugMember -Force
        $PasswordOlderThan1Year = Test-PPUserPasswordOlderThan1Year -User $_
        $_ | Add-Member -NotePropertyName PasswordOlderThan1Year -NotePropertyValue $PasswordOlderThan1Year -Force
        # TODO figure out how to pass PugCreatedDate into this. Probably by enriching the Domain object. 
        $PasswordOlderThanPug = Test-PPUserPasswordOlderThanPug -User $_
        $_ | Add-Member -NotePropertyName PasswordOlderThanPug -NotePropertyValue $PasswordOlderThanPug -Force
        # $_ | Add-Member -NotePropertyName Domain -NotePropertyValue $_.RootDomain -Force
        if ($_.PugMember -eq $false) {
            $RecentNTLMLogon = Test-PPUserNtlmLogon -User $_ -DC ($Dcs | Where-Object { $_.AuditingEnabled -eq $true })
            $_ | Add-Member -NotePropertyName RecentNTLMLogon -NotePropertyValue $RecentNTLMLogon -Force
            $RecentWeakKerberosLogon = Test-PPUserWeakKerberosLogon -User $_ -DC ($Dcs | Where-Object { $_.AuditingEnabled -eq $true })
            $_ | Add-Member -NotePropertyName RecentWeakKerberosLogon -NotePropertyValue $RecentWeakKerberosLogon -Force
        }
    }
    
    Write-PPHost -Type Info -Message "Collecting Domain Admin Group Membership"
    $DomainAdmins = $Domains.AdminGroupSids | ForEach-Object {
        Expand-PPGroupMembership -Sid $_ | Select-Object -Unique -PipelineVariable principal | ForEach-Object {
            if ($ForestAdmins.DistinguishedName -notcontains $principal.DistinguishedName) {
                $principal
            }
        }
    }
    Write-PPHost -Type Info -Message "Enriching Collected Domain Admin Information"
    $DomainAdmins | ForEach-Object {
        $PugMember = Test-PPUserPugMember -User $_ -PugMembership $PugMembers
        $_ | Add-Member -NotePropertyName PugMember -NotePropertyValue $PugMember -Force
        $PasswordOlderThan1Year = Test-PPUserPasswordOlderThan1Year -User $_
        $_ | Add-Member -NotePropertyName PasswordOlderThan1Year -NotePropertyValue $PasswordOlderThan1Year -Force
        # TODO figure out how to pass PugCreatedDate into this. Probably by enriching the Domain object. 
        $PasswordOlderThanPug = Test-PPUserPasswordOlderThanPug -User $_
        $_ | Add-Member -NotePropertyName PasswordOlderThanPug -NotePropertyValue $PasswordOlderThanPug -Force
        if (-not $PugMember) {
            $RecentNTLMLogon = Test-PPUserNtlmLogon -User $_ -DC ($Dcs | Where-Object { $_.AuditingEnabled -eq $true })
            $_ | Add-Member -NotePropertyName RecentNTLMLogon -NotePropertyValue $RecentNTLMLogon -Force
            $RecentWeakKerberosLogon = Test-PPUserWeakKerberosLogon -User $_ -DC ($Dcs | Where-Object { $_.AuditingEnabled -eq $true })
            $_ | Add-Member -NotePropertyName RecentWeakKerberosLogon -NotePropertyValue $RecentWeakKerberosLogon -Force
        }
    }
    #endregion expand group
    #endregion collection and enrichment

    $Environment = @{
        Forest       = $Forest
        Domains      = $Domains
        Dcs          = $Dcs
        ForestAdmins = $ForestAdmins
        DomainAdmins = $DomainAdmins
    }

    Write-Output $Environment
    Write-PPHost -Type Info -Message 'Environmental Collection and Enrichment Complete.'
    Read-Host 'Press Enter to Continue'; Write-Host
}
function Test-PPEnvironment {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Paramter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Environment
    )

    #requires -Version 5

    #region static values
    $FLHashtable = @{
        0  = 'Windows Server 2000'
        1  = 'Windows Server 2003 Interim'
        2  = 'Windows Server 2003'
        3  = 'Windows Server 2008'
        4  = 'Windows Server 2008 R2'
        5  = 'Windows Server 2012'
        6  = 'Windows Server 2012 R2'
        7  = 'Windows Server 2016'
        10 = 'Windows Server 2025'
    }
    #endregion static values

    #region show environmental results
    #region show forest results
    
    Write-PPHost -Type Title -Message "Forest Functional Level (FFL)"
    Write-PPHost -Type Subtitle -Message @'
If the FFL is Server 2012 R2 or higher, the Protected Users Group exists in all domains in the forest.
    All domains will receive host- and domain controller-level protections.
'@
    Write-PPHost -Type Subtitle -Message @'
If the FFL is Server 2012 or lower, the Protected Users Group may or may not exist in domains in the forest.
    Host- and domain controller-level protections may not be consistently applied.

'@
    if ($Environment.Forest.PugFFL) {
        Write-PPHost -Type Success @"
$($Environment.Forest.Name) FFL is $($FLHashtable[$Environment.Forest.ForestModeLevel]).
    The Protected Users Group exists in all domains in the forest.
"@
        Read-Host 'Press Enter to Continue'
    }
    else {
        Write-PPHost -Type Warning @"
$($Environment.Forest.Name) FFL is $($FLHashtable[$Environment.Forest.ForestModeLevel]).
    Domains in this forest can support host-level PUG protections if they:
      - Have a functional level of 2008 or higher.
      - Have a DC running 2012 R2 or newer holding the PDC emulator role.
    Domains in this forest can support domain controller-level PUG protections if they:
      - Have a functional level of 2012 R2 or higher.
"@
        Read-Host 'Press Enter to Continue'
    }
    #endregion show forest results

    #region show domain results
    
    if ($Environment.Forest.PugFFL -eq $false) {
        Write-PPHost -Type Title -Message "Domain Functional Level (FFL)"
        Write-PPHost -Type Subtitle -Message @'
If the DFL is Server 2012 R2 or higher, the Protected Users Group exists in that domain.
    Host- and domain controller-level protections will apply within the domain but may not extend beyond that domain.
'@
        Write-PPHost -Type Subtitle -Message @'
If the DFL is Server 2008-2012, the Protected Users Group *may* exist in that domain.
    Only host-level protections will apply within the domain but may not extend beyond that domain.
'@
        Write-PPHost -Type Subtitle -Message @'
If the DFL is Server 2008-2012, the Protected Users Group *may* exist in that domain.
    If the Protected Users Group exists, only host-level protections will apply within the domain.
    Protections may not extend beyond that domain.
'@
        $Environment.Domains | ForEach-Object {
            if ($_.PugExists -and $_.PugDfl) {
                Write-PPHost -Type Success -Message @"
$($_.Name) DFL is $($FLHashtable[$_.DomainModeLevel]).
    The Protected Users group exists in this domain.
    Host- and domain controller-level protections will apply to all intra-domain traffic.
    Only host-level protections will apply to inter-domain traffic with 
    domains running Server 2008-2012.
    No protections will apply to traffic with domains running Server 2003 or lower.
"@
            }
            elseif ($_.PugExists -and ($_.PugDfl -eq $false) ) {
                Write-PPHost -Type Warning -Message @"
$($_.Name) DFL is $($FLHashtable[$_.DomainModeLevel]).
    The Protected Users group exists in this domain, but the DFL is too low for full protection.
    Host-level protections will apply to all intra-domain traffic and any inter-domain traffic
    with domains running Server 2008-2012 DFL.
    Domain controller-level protections will not apply to any traffic.
    No protections will apply to traffic with domains running Server 2003 or lower.
"@
            }
            else {
                Write-PPHost -Type Error -Message @"
$($_.Name) DFL is $($FLHashtable[$_.DomainModeLevel])
    The Protected Users group does not exist in this domain.
    No protections will apply to intra-domain traffic or inter-domain traffic.
"@
            }
        }
        Read-Host 'Press Enter to Continue'
    }
    #endregion show domain results

    #region show DC results
    
    if ($Environment.Forest.PugFFL -eq $false) {
        Write-Output $Environment.Domains -PipelineVariable environmentdomains | ForEach-Object {
            if ( ($environmentdomains.PugDFL -eq $false) -and ($environmentdomains.PugExists -eq $false) ) {
                Write-PPHost -Type Title -Message "Domain Controller (DC) Operating System (OS)"
                Write-PPHost -Type Subtitle -Message @'
If the DFL is Server 2008-2012, the Protected Users Group can be created in that domain
    by promoting a Server 2012 R2 DC into the Primary Domain Controller emulator (PDCe) role.
    Host-level protections will apply within the domain but may not extend beyond that domain.
'@
                $Environment.Dcs | ForEach-Object {
                    if ($_.PugOs) {
                        Write-PPHost -Type Success -Message "$($_.Name) is running $($_.OSVersion) and can support the PUG!"
                    }
                    else {
                        Write-PPHost -Type Error -Message "$($_.Name) is running $($_.OSVersion) and cannot support the PUG."
                    }
                }
                Read-Host 'Press Enter to Continue'
            }
        }
    }

    Write-PPHost -Type Title -Message "DC Logging Configuration"
    Write-PPHost -Type Subtitle -Message 'Proper Audit Logging is required to check for the use of NTLM and weak Kerberos.'
    $Environment.Dcs | ForEach-Object {
        if ($_.AuditingEnabled) {
            Write-PPHost -Type Success -Message "$($_.Name) has Logon Auditing properly configured."
        }
        else {
            Write-PPHost -Type Error -Message "$($_.Name) does not have Logon Auditing properly configured."
            $Answer = $null
            while ($Answer -ne 'y' -and $Answer -ne 'n') {
                $Answer = Read-PPHost -Message "Do you want to see a code snippet for enabling Logon Auditing on $($_.Name)? (y/n)"
                Write-Host
            }

            if ($Answer -eq 'y') {
                Write-PPHost -Type Code -Message @"
Invoke-Command -ComputerName $($_.Name) -ScriptBlock { auditpol /set /subcategory:Logon /success:enable /failure:enable }
"@
                Write-PPHost -Type Info -Message "Note: this command must be run with appropriate permissions."
            }
        }
    }

    Read-Host 'Press Enter to Continue'
    #endregion show DC results

    #region show User results
    $ForestAdmins = $Environment.ForestAdmins
    $DomainAdmins = $Environment.DomainAdmins
    $ADAdmins = $ForestAdmins + $DomainAdmins
    $SelectProperties = @(
        'Forest',
        'Domain',
        'SamAccountName',
        'DistinguishedName',
        'PugMember',
        'PasswordOlderThan1Year',
        'PasswordOlderThanPug',
        'RecentNTLMLogon',
        'RecentWeakKerberosLogon',
        'StructuralObjectClass'
    )

    $SortProperties = @(
        'Domain',
        'SamAccountName',
        'DistinguishedName'
    )

    Write-PPHost -Type Title -Message "AD Admin PUG Membership"
    Write-PPHost -Type Subtitle -Message @"
"AD Admins" are members of the builtin domain Administrators, Domain Admins, Enterpise Admins, and/or Schema Admins groups.
    All AD Admin *users* should be members of the Protected Users Group.
    *Service accounts and computer accounts* should not be members of the Protected Users Group.

"@
    Write-PPHost -Type Info -Message "The following AD Admins are members of the Protected Users Group:"

    $ADAdmins | Select-Object $SelectProperties | Sort-Object -Unique $SortProperties | ForEach-Object {
        if ($_.PugMember) {
            Write-PPHost -Type Success -Message "$($_.Domain)\$($_.SamAccountName)"
        }
    }
    Read-Host 'Press Enter to Continue'
    
    # Check and stop code if all admins are in PUG
    $NonPugMembers = $ADAdmins | Where-Object { -not $_.PugMember }
    if (-not $NonPugMembers) {
        Write-PPHost -Type Success -Message "All AD Admins are already members of Protected Users Group. No further action needed."
        return
    }

    Write-PPHost -Type Info -Message "The following AD Admins are not members of the Protected Users Group:"
    $ADAdmins | Select-Object $SelectProperties | Sort-Object -Unique $SortProperties | ForEach-Object {
        if (-not $_.PugMember) {
            Write-PPHost -Type Error -Message "$($_.Domain)\$($_.SamAccountName)"
        }
    }
    Read-Host 'Press Enter to Continue'

    Write-PPHost -Type Title -Message "AD Admin Password Age"
    Write-PPHost -Type Subtitle -Message @"
Because the Protected User Group's protections are not configurable, it's crucial
    that all members of the group have changed their password since the domain was
    upgraded to Server 2008.

    Additionally, regardless of NIST 800-63B guidance, AD Admins should have regular
    password changes. This check will alert on either condition.

"@
    Write-PPHost -Type Info -Message "The following AD Admins have an old password that should be changed:"
    $ADAdmins | Select-Object $SelectProperties | Sort-Object -Unique $SortProperties | ForEach-Object {
        if (-not $_.PugMember -and $_.PasswordOlderThan1Year -and $_.PasswordOlderThanPug) {
            Write-PPHost -Type Error -Message "$($_.Domain)\$($_.SamAccountName) has a password older than 1 year and older than the PUG."
        }
        elseif (-not $_.PugMember -and $_.PasswordOlderThan1Year -and -not $_.PasswordOlderThanPug) {
            Write-PPHost -Type Warning -Message "$($_.Domain)\$($_.SamAccountName) has a password older than 1 year."
        }
        elseif (-not $_.PugMember -and -not $_.PasswordOlderThan1Year -and $_.PasswordOlderThanPug) {
            Write-PPHost -Type Error -Message "$($_.Domain)\$($_.SamAccountName) has a password older than the PUG."
        }
    }
    Read-Host 'Press Enter to Continue'

    Write-PPHost -Type Title -Message "AD Admins Using NTLM Authentication"
    Write-PPHost -Type Subtitle -Message @"
Members of the Protected Users Group cannot use NTLM authentication (because it's old and busted.)

"@ 
    Write-PPHost -Type Info -Message "The following users should be investigated to determine why they are using NTLM:"
    $ADAdmins | Select-Object $SelectProperties | Sort-Object -Unique $SortProperties | ForEach-Object {
        # TODO Remove (-not $_.PugMember) condition after recording demo
        if ((-not $_.PugMember) -and ($_.RecentNTLMLogon)) {
            Write-PPHost -Type Error -Message "$($_.Domain)\$($_.SamAccountName)"
        }
    }
    Read-Host 'Press Enter to Continue'

    Write-PPHost -Type Title -Message "AD Admins Using Weak Kerberos Encryption Algorithms During Authentication"
    Write-PPHost -Type Subtitle -Message @"
Members of the Protected Users Group cannot use DES or RC4 encryption during authentication (because it's old and busted.)

"@
    Write-PPHost -Type Info -Message "The following users should be investigated to determine why they are using weak Kerberos encryption algo-riddims:"
    $ADAdmins | Select-Object $SelectProperties | Sort-Object -Unique $SortProperties | ForEach-Object {
        # TODO Remove (-not $_.PugMember) condition after recording demo
        if ((-not $_.PugMember) -and ($_.RecentWeakKerberosLogon) ) {
            Write-PPHost -Type Error -Message "$($_.Domain)\$($_.SamAccountName)"
        }
    }
    Read-Host 'Press Enter to Continue'

    Write-PPHost -Type Title -Message "AD Admins That CANNOT Be Added to the PUG"
    Write-PPHost -Type Subtitle -Message @"
AD Admins that meet any of the following conditions cannot be added to the Protected Users Group (and probably shouldn't be AD Admins at all):
  - Computer accounts
  - Service accounts (managed or otherwise)

"@
    Write-PPHost -Type Info -Message "The following AD Admins cannot be added to the Protected Users Group (and probably should be removed from AD Admin groups:"
    $ADAdmins | Select-Object $SelectProperties | Sort-Object -Unique $SortProperties | ForEach-Object {
        if ($_.StructuralObjectClass -notmatch 'user|iNetOrgPerson') {
            Write-PPHost -Type Error -Message "$($_.Domain)\$($_.SamAccountName)"
        }
    }
    Read-Host 'Press Enter to Continue'

    Write-PPHost -Type Title -Message "AD Admins That Could Be Added to PUG Immediately"
    Write-PPHost -Type Subtitle -Message @"
AD Admins that meet the following conditions can likely be added to the Protected Users Group:
  - Is a user or iNetOrgPerson (not a computer or service account)
  - Have a password newer than the Protected User Group's creation date
  - Have had a recent logon
  - Have not used weak authentication methods during logon (NTLM, Kerb.\eros DES/RC4)
  
"@
    Write-PPHost -Type Info -Message "The following AD Admins should be safe to add to the Protected Users Group immediately!"
    $ADAdmins | Select-Object $SelectProperties | Sort-Object -Unique $SortProperties | ForEach-Object {
        if (-not $_.PugMember -and ($_.PasswordOlderThanPug -or $_.RecentNTLMLogon -or $_.RecentWeakKerberosLogon) ) {
        }
        elseif (-not $_.PugMember -and 
            -not $_.PasswordOlderThanPug -and 
            -not $_.RecentNTLMLogon -and 
            -not $_.RecentWeakKerberosLogon -and
            $_.StructuralObjectClass -match 'user|iNetOrgPerson') {
            Write-PPHost -Type Success -Message "$($_.Domain)\$($_.SamAccountName)"
        }
    }

    $Answer = $null
    while ($Answer -ne 'y' -and $Answer -ne 'n') {
        $Answer = Read-PPHost -Message "Do you want to see code snippets for adding users to the Protected Users Group? (y/n)"
        Write-Host
    }

    if ($Answer -eq 'y') {
        $ADAdmins | Select-Object $SelectProperties | Sort-Object -Unique $SortProperties | ForEach-Object {
            if (-not $_.PugMember -and 
                -not $_.PasswordOlderThanPug -and 
                -not $_.RecentNTLMLogon -and 
                -not $_.RecentWeakKerberosLogon -and
                $_.StructuralObjectClass -match 'user|iNetOrgPerson') {
                Write-PPHost -Type Code -Message "Add-ADGroupMember -Identity 'Protected Users' -Members '$($_.SamAccountName)' -Server '$($_.Domain)'"
            }
        }
        Write-Host
        Write-PPHost -Type Info -Message @"
Note: these commands must be run with appropriate permissions.
    Also, for the love of John Strand, if this is your first time using this group, only add one user.
    
    Please.
"@
    }
    #endregion show User results
    #endregion show environmental results
}

function Get-PPForest {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    # TODO Accept other forests in -ForestFQDN parameter
    [CmdletBinding()]
    param(
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Forest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
        Write-Output $Forest
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    } 
}
function Get-PPForestAdminGroupSid {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Forest
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $Forest) {
            $Forest = Get-PPForest
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $RootDomainSid = Get-PPDomainSid -Domain $Forest.RootDomain
        @("$RootDomainSid-518", "$RootDomainSid-519") | ForEach-Object {
            $AdaGroupSid = [System.Security.Principal.SecurityIdentifier]::New($_)
            $AdaGroupSid | Add-Member -NotePropertyName Domain -NotePropertyValue $Forest.RootDomain -Force
            Write-Output $AdaGroupSid
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Test-PPForestFL {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Forest
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }
    
    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Forest | ForEach-Object {
            if ($_.ForestModeLevel -ge 6) {
                Write-Output $true 
            }
            else {
                Write-Output $false
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Expand-PPGroupMembership {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    # TODO Update to handle users with non-standard PGID
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$Sid
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Output $Sid -PipelineVariable groupsid | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain', $groupsid.Domain)
            $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext, $groupsid.Value)
            try {
                $GroupPrincipal.GetMembers($true) | ForEach-Object {
                    $_ | Add-Member -NotePropertyName Domain -NotePropertyValue $groupsid.Domain -Force
                    Write-Output $_
                }
            }
            catch {
                Write-PPHost -Type Warning -Message "Group SID $($groupsid.Value) does not exist in $($groupsid.Domain)."
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}
function Test-PPUserNtlmLogon {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$User,
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$DC
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $DC) {
            $DC = Get-PPDC
        }

        $DC | ForEach-Object {
            if ($_.PSobject.Properties.Name -notcontains 'AuditingEnabled') {
                try {
                    $AuditingConfiguration = Get-PPDCLogConfiguration -DC $_
                    $AuditingEnabled = Test-PPDCLogConfiguration -Configuration $AuditingConfiguration
                    $_ | Add-Member -NotePropertyName AuditingEnabled -NotePropertyValue $AuditingEnabled -Force
                    if ( ($_.AuditingEnabled) -and ($_.PSobject.Properties.Name -notcontains 'NtlmLogons') ) {
                        $NtlmLogons = Get-PPDCNtlmLogon -DC $_
                        $_ | Add-Member -NotePropertyName NtlmLogons -NotePropertyValue $NtlmLogons -Force
                    }
                    else {
                        Write-PPHost -Type Warning -Message "Logon auditing is not enabled on $($_.Name)"
                    }
                }
                catch {
                }
            }
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Output $User -PipelineVariable loopuser | ForEach-Object {
            $NtlmLogon = $false
            $DC | ForEach-Object {
                if ($_.NtlmLogons.Message -match $loopuser.Sid) {
                    $NtlmLogon = $true
                }
            }

            $NtlmLogon
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }
}

function Test-PPUserPasswordOlderThan1Year {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$User
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $User | ForEach-Object {
            if ($_.LastPasswordSet -lt (Get-Date).AddDays(-365)) {
                Write-Output $true
            }
            else {
                Write-Output $false
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Test-PPUserPasswordOlderThanPug {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$User
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $User | ForEach-Object {
            $PugCreatedDate = Get-PPDomainPugCreatedDate -Domain $_.Domain
            if ($_.LastPasswordSet -lt $PugCreatedDate) {
                Write-Output $true
            }
            else {
                Write-Output $false
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Test-PPUserPugMember {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$User,
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$PugMembership
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $PugMembership) {
            $PugMembership = Get-PPForest | Get-PPDomain | Get-PPDomainPugSid | Expand-PPGroupMembership
        } 
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $User | ForEach-Object {
            if ($PugMembership -contains $_) {
                Write-Output $true
            }
            else {
                Write-Output $false
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}

function Test-PPUserWeakKerberosLogon {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$User,
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$DC
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Output $User -PipelineVariable loopuser | ForEach-Object {
            $WeakKerberosLogon = $false
            $DC | ForEach-Object {
                if ($_.WeakKerberosLogons.Message -match $loopuser.Sid) {
                    $WeakKerberosLogon = $true
                }
            }

            $WeakKerberosLogon
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }
}

function Invoke-PowerPUG {
    [CmdletBinding()]
    param (
        # TODO accept ForestFQDN as string
        # [Parameter(ValueFromPipeline)]
        # [string]$ForestFQDN,
        # [System.Management.Automation.PSCredential]$Credential
    )

    #region show logo
    Show-PPLogo -Version (Get-Date -Format yyyy.M.d)
    #endregion show logo

    if (Test-PPIsDC) {
        if (Test-PPIsElevated) {
        }
        else {
            $Executable = if ($Host.Name -eq 'Windows PowerShell ISE Host') {
                'powershell_ise.exe'
            }
            elseif ( ($Host.Name -eq 'ConsoleHost') -and ($Host.Version.Major -gt 6) ) {
                'pwsh.exe'
            }
            else {
                'powershell.exe'
            }
    
            throw "When run on a DC, this script must be run in an elevated prompt. Please re-open $Executable using `"Run as Administrator`" and start this script again."
        }
    }

    $Environment = Get-PPEnvironment
    Test-PPEnvironment -Environment $Environment

    Show-PPOutro
}


# Export functions and aliases as required
Export-ModuleMember -Function @('Expand-PPGroupMembership', 'Get-PPDC', 'Get-PPDCAuditPolicy', 'Get-PPDCLogConfiguration', 'Get-PPDCNtlmLogon', 'Get-PPDCWeakKerberosLogon', 'Get-PPDomain', 'Get-PPDomainAdminGroupSid', 'Get-PPDomainKrbtgt', 'Get-PPDomainPugCreatedDate', 'Get-PPDomainPugSid', 'Get-PPDomainSid', 'Get-PPEnvironment', 'Get-PPForest', 'Get-PPForestAdminGroupSid', 'Invoke-PowerPUG', 'Test-PPDCLogConfiguration', 'Test-PPDCOS', 'Test-PPDCRemotingEnabled', 'Test-PPDomainFL', 'Test-PPDomainPugExists', 'Test-PPEnvironment', 'Test-PPForestFL', 'Test-PPUserNtlmLogon', 'Test-PPUserPasswordOlderThan1Year', 'Test-PPUserPasswordOlderThanPug', 'Test-PPUserPugMember', 'Test-PPUserWeakKerberosLogon') -Alias @()