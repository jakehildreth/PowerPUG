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
        $Sid
    )

    #requires -Version 5

    begin {
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        Write-Output $Sid -PipelineVariable groupsid | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain',$groupsid.Domain)
            $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext,$groupsid.Value)
            try {
                $GroupPrincipal.GetMembers($true) | ForEach-Object {
                    $_ | Add-Member -NotePropertyName Domain -NotePropertyValue $groupsid.Domain -Force
                    Write-Output $_
                }
            } catch {
                Write-Warning "Group SID $($_.Value) does not exist in $($_.Domain)."
            }
        }
    }

    end {
    }
}