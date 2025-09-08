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
    } else {
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
            } elseif ($_.PugExists -and ($_.PugDfl -eq $false) ) {
                Write-PPHost -Type Warning -Message @"
$($_.Name) DFL is $($FLHashtable[$_.DomainModeLevel]).
    The Protected Users group exists in this domain, but the DFL is too low for full protection.
    Host-level protections will apply to all intra-domain traffic and any inter-domain traffic
    with domains running Server 2008-2012 DFL.
    Domain controller-level protections will not apply to any traffic.
    No protections will apply to traffic with domains running Server 2003 or lower.
"@
            } else {
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
                    } else {
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
        } else {
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
    if ($Environment.ForestAdmins) {
        $ForestAdmins = [System.Collections.Generic.List[PSObject]]@($Environment.ForestAdmins)
    }

    if ($Environment.DomainAdmins) {
        $DomainAdmins = [System.Collections.Generic.List[PSObject]]@($Environment.DomainAdmins)
    }
    
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
    Write-PPHost -Type Info -Message "The following AD Admins ARE members of the Protected Users Group:"

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

    Write-PPHost -Type Info -Message "The following AD Admins ARE NOT members of the Protected Users Group:"
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
        } elseif (-not $_.PugMember -and $_.PasswordOlderThan1Year -and -not $_.PasswordOlderThanPug) {
            Write-PPHost -Type Warning -Message "$($_.Domain)\$($_.SamAccountName) has a password older than 1 year."
        } elseif (-not $_.PugMember -and -not $_.PasswordOlderThan1Year -and $_.PasswordOlderThanPug) {
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
    Write-PPHost -Type Info -Message "The following AD Admins cannot be added to the Protected Users Group (and probably should be removed from AD Admin groups):"
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
        } elseif (-not $_.PugMember -and 
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
