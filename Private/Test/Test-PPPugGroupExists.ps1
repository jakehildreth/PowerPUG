function Test-PPPugGroupExists {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PPGroupSids
    )

    #requires -Version 5

    begin {
        if ($null -eq $PPGroupSid) {
            $PPGroupSids = Get-PPPugGroupSid
        }
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        $PPGroupSids | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain',$_.Domain)
            $PPGroupExists = $false
            try {
                $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext,$_.Value)
                $GroupPrincipal.GetMembers() | Out-Null
                $PPGroupExists = $true
            } catch {
            }

            $Return = [PSCustomObject]@{
                Name  = $_.Domain
                Value = $PPGroupExists
            }

            Write-Output $Return
        }
    }

    end {
    }
}
