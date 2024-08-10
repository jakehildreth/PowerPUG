function Test-PPPugGroupExists {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PugGroupSids
    )

    #requires -Version 5

    begin {
        if ($null -eq $PugGroupSid) {
            $PugGroupSids = Get-PPPugGroupSid
        }
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        $PugGroupSids | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain',$_.Domain)
            $PugGroupExists = $false
            try {
                [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext,$_.Value)
                $PugGroupExists = $true
            } catch {
            }

            $Return = [PSCustomObject]@{
                Name           = $_.Domain
                PugGroupExists = $PugGroupExists
            }

            Write-Output $Return
        }
    }

    end {
    }
}
