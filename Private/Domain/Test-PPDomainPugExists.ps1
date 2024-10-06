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
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        Write-Verbose "Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Domain | ForEach-Object {
            $PugExists = $false
            if (-not $_.PugSid) {
                $PugSid = Get-PPDomainPugSid -Domain $_
            } else {
                $PugSid = $_.PugSid
            }
            try {
                $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain', $_)
                $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext, $PugSid)
                $GroupPrincipal.GetMembers() | Out-Null
                $PugExists = $true
            } catch {
            }

            Write-Output $PugExists
        }
    }

    end {
        Write-Verbose "Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}
