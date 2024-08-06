function Get-PugTargetAccount {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PugDomains
    )

    #requires -Version 5

    begin {
        $RootDomainSid = (Get-PugForest).RootDomain | Get-PugDomainSid
        $ADAdminGroupSids = @('S-1-5-32-544',"$RootDomainSid-518","$RootDomainSid-519")
    }

    process {
        $PugDomains | ForEach-Object {
            $DomainSid = $_ | Get-PugDomainSid
            $ADAdminGroupSids += "$DomainSid-512"
        }
    }

    end {
        $ADAdminGroupSids
    }
}
