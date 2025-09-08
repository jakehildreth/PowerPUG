@{
    AliasesToExport      = @()
    Author               = 'Jake Hildreth'
    CmdletsToExport      = @()
    CompanyName          = ''
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2023 - 2025 Jake Hildreth. All rights reserved.'
    Description          = 'PowerPUG helps AD Admins use the Protected Users Group safely.'
    FunctionsToExport    = @('Get-PPDC', 'Get-PPDCAuditPolicy', 'Get-PPDCLogConfiguration', 'Get-PPDCNtlmLogon', 'Get-PPDCWeakKerberosLogon', 'Test-PPDCLogConfiguration', 'Test-PPDCOS', 'Test-PPDCRemotingEnabled', 'Get-PPDomain', 'Get-PPDomainAdminGroupSid', 'Get-PPDomainKrbtgt', 'Get-PPDomainPugCreatedDate', 'Get-PPDomainPugSid', 'Get-PPDomainSid', 'Test-PPDomainFL', 'Test-PPDomainPugExists', 'Get-PPEnvironment', 'Test-PPEnvironment', 'Get-PPForest', 'Get-PPForestAdminGroupSid', 'Test-PPForestFL', 'Expand-PPGroupMembership', 'Invoke-PowerPUG', 'Test-PPUserNtlmLogon', 'Test-PPUserPasswordOlderThan1Year', 'Test-PPUserPasswordOlderThanPug', 'Test-PPUserPugMember', 'Test-PPUserWeakKerberosLogon')
    GUID                 = '3f8afba8-e266-4a4b-9f09-b2d7ab35eba9'
    ModuleVersion        = '2025.9.8'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            ExternalModuleDependencies = @('CimCmdlets', 'Microsoft.PowerShell.Archive', 'Microsoft.PowerShell.Diagnostics', 'Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Security', 'Microsoft.PowerShell.Utility', 'Microsoft.WSMan.Management')
            Tags                       = @('Windows', 'MacOS', 'Linux')
        }
    }
    RequiredModules      = @('CimCmdlets', 'Microsoft.PowerShell.Archive', 'Microsoft.PowerShell.Diagnostics', 'Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Security', 'Microsoft.PowerShell.Utility', 'Microsoft.WSMan.Management')
    RootModule           = 'PowerPUG.psm1'
}