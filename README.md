# PowerPUG!

PowerPUG! helps Active Directory admins safely adopt the Protected Users Group (PUG) without breaking things in production.

The PUG provides strong, non-configurable protections (no NTLM, no weak Kerberos, no credential caching) that stop common credential attacks cold. The catch: those same protections break service accounts, legacy apps, and bad admin habits. Most environments never adopt the PUG because they don't know what will break until it already has.

PowerPUG! fixes that. It checks prerequisites, scours DC event logs for incompatible authentication behavior, and identifies which users are safe to add to the PUG — before you make the move.

## Requirements

- Windows (PowerShell 5.1 or PowerShell 7+)
- Must be run on or have network access to a Domain Controller
- PowerShell Remoting enabled on all DCs being analyzed
- DC Security audit logging enabled (Logon/Logoff: Logon — Success and Failure)
- Forest Functional Level: Windows Server 2012 R2 or higher recommended

No RSAT or ActiveDirectory module required.

## Installation

Install from the PowerShell Gallery (preferred):

```powershell
Install-Module -Name PowerPUG -Scope CurrentUser -Force
```

Install manually from GitHub:

```powershell
# Download and extract the latest release, then:
Import-Module .\PowerPUG.psd1
```

## Quick Start

```powershell
# Run the full interactive assessment
Invoke-PowerPUG

# Check a specific user against DC event logs
$env = Get-PPEnvironment
Test-PPUserNtlmLogon -User $someUser -DC $env.DomainControllers
Test-PPUserWeakKerberosLogon -User $someUser -DC $env.DomainControllers

# Check if a user is already in the PUG
Test-PPUserPugMember -User $someUser
```

## How It Works

`Invoke-PowerPUG` runs a guided assessment in sequence:

1. **Prerequisites** — checks forest/domain functional level (2012 R2+ required for full PUG protections), verifies the PUG exists in each domain, and confirms DCs are reachable via PS Remoting
2. **DC OS check** — confirms each DC runs a Windows Server version that supports PUG (2012 R2 through 2025)
3. **Audit logging check** — verifies Logon/Logoff auditing is enabled on each DC; skips log analysis on DCs where it isn't
4. **Event log analysis** — remotely queries DC Security logs for NTLM logons (Event 4624) and weak Kerberos (Event 4768, encryption type not AES)
5. **User assessment** — for each admin-group member, tests for: NTLM logon activity, weak Kerberos logon activity, password older than 1 year, password older than the PUG itself, and current PUG membership

## Functions

### Environment

| Function | Description |
|---|---|
| `Get-PPEnvironment` | Collects and enriches full forest/domain/DC state into a single object |
| `Test-PPEnvironment` | Displays results of the environment check with guidance |

### Forest

| Function | Description |
|---|---|
| `Get-PPForest` | Gets the current AD forest |
| `Get-PPForestAdminGroupSid` | Gets SIDs for forest-level admin groups (Enterprise Admins, Schema Admins) |
| `Test-PPForestFL` | Returns `$true` if Forest Functional Level is 2012 R2 (level 6) or higher |

### Domain

| Function | Description |
|---|---|
| `Get-PPDomain` | Gets all domains in the forest |
| `Get-PPDomainSid` | Gets the SID for a domain |
| `Get-PPDomainAdminGroupSid` | Gets SIDs for domain-level admin groups (Domain Admins, Administrators) |
| `Get-PPDomainPugSid` | Gets the SID of the Protected Users group |
| `Get-PPDomainPugCreatedDate` | Gets the creation date of the Protected Users group |
| `Get-PPDomainKrbtgt` | Gets the krbtgt account object |
| `Test-PPDomainFL` | Returns `$true` if Domain Functional Level is 2012 R2 (level 6) or higher |
| `Test-PPDomainPugExists` | Returns `$true` if the Protected Users group exists and is accessible |

### Domain Controllers

| Function | Description |
|---|---|
| `Get-PPDC` | Gets all DCs for one or more domains |
| `Get-PPDCAuditPolicy` | Gets the audit policy configuration from a DC (runs locally via remoting) |
| `Get-PPDCLogConfiguration` | Gets Logon/Logoff audit settings from a DC via PS Remoting |
| `Get-PPDCNtlmLogon` | Reads Event 4624 (NTLM) from DC Security logs via PS Remoting |
| `Get-PPDCWeakKerberosLogon` | Reads Event 4768 with non-AES encryption from DC Security logs via PS Remoting |
| `Test-PPDCOS` | Returns `$true` if the DC OS supports the Protected Users Group (2012 R2+) |
| `Test-PPDCRemotingEnabled` | Returns `$true` if PS Remoting is reachable on the DC |
| `Test-PPDCLogConfiguration` | Returns `$true` if Logon auditing is set to Success and Failure |

### Groups

| Function | Description |
|---|---|
| `Expand-PPGroupMembership` | Recursively enumerates group members by SID across domains |

### Users

| Function | Description |
|---|---|
| `Test-PPUserNtlmLogon` | Returns `$true` if the user has NTLM logon events in DC logs |
| `Test-PPUserWeakKerberosLogon` | Returns `$true` if the user has weak Kerberos logon events in DC logs |
| `Test-PPUserPasswordOlderThan1Year` | Returns `$true` if the user's password hasn't changed in over a year |
| `Test-PPUserPasswordOlderThanPug` | Returns `$true` if the user's password predates the PUG's creation |
| `Test-PPUserPugMember` | Returns `$true` if the user is already in the Protected Users group |

## License

MIT License w/Commons Clause - see [LICENSE](LICENSE) file for details.

---

Made with 💜 by [Jake Hildreth](https://jakehildreth.com)
