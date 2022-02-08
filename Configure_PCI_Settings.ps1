# Configure these to your preferred values
$adminUsername = "au"
$guestUsername = "gu"

# PCI 1.4 Installing personal firewall software on any mobile and employee-owned computers with direct connectivity to the Internet - Firewall"
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile -Name EnableFirewall -Value 1
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile -Name EnableFirewall -Value 1
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile -Name EnableFirewall -Value 1

# PCI 2.2.2 Disable all unnecessary and insecure services and protocols
$pci222_servicesToDisable = @(
  "Alerter"
  ,"AppMgr"
  ,"Appmon"
  ,"BINLSVC"
  ,"BTAGService" # Added
  ,"BthAvctpSvc" # Added
  ,"bthserv" # Added
  ,"CiSvc"
  ,"ClipSrv"
  ,"FAX"
  ,"fhsvc" # Added
  ,"helpsvc"
  ,"HTTPFilter"
  ,"IISADMIN"
  ,"LanmanServer" # Added
  ,"LicenseService"
  ,"lmhosts" # Added
  ,"MacFile"
  ,"MacPrint"
  ,"MapsBroker" # Added
  ,"Messenger"
  ,"mnmsrvc"
  ,"MSFtpsvc"
  ,"Netman"
  ,"Ntfrs"
  ,"NWCWorkstation"
  ,"Pop3Svc"
  ,"RasAuto"
  ,"RasMan"
  ,"RDSessMgr"
  ,"RemoteRegistry"
  ,"Remote_Storage_Server"
  ,"Remote_Storage_User_Link"
  ,"RpcLocator"
  ,"SMTPSVC"
  ,"SNMP"
  ,"SNMPTRAP"
  ,"SCardSvr" # Added
  ,"ShellHWDetection" # Added
  ,"Spooler"
  ,"srvcsurg"
  ,"TapiSrv"
  ,"TermService"
  ,"TFTPD"
  ,"TlntSvr"
  ,"TrkWks" # Added
  ,"WinHttpAutoProxySvc" # Added
  ,"W3SVC"
  ,"WZCSVC"
)
foreach ($s in $pci222_servicesToDisable) {
  Set-Service -Name Fax -StartupType Disabled -ErrorAction SilentlyContinue
}

# PCI 2.2.4 Configure system security parameters to prevent misuse - These settings are to be configured using the Local Security Policy using the "secedit" tool
$pci224_lsp_systemAccess = @(
  "MinimumPasswordAge = 1" # Minimum Password Age: 1 day
  ,"LSAAnonymousNameLookup = 0" # Network Access: Allow Anonymous SID/Name Translation: Disabled
  ,"EnableGuestAccount = 0" # Accounts: Guest Account Status: Disabled
  ,"NewAdministratorName = ""$adminUsername""" # Accounts: Rename Administrator Account: non-standard
  ,"NewGuestName = ""$guestUsername""" # Accounts: Rename Guest Account: non-standard

)

$pci224_lsp_registryValues = @(
  "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymousSAM=4,1" # Network Access: Do not allow Anonymous Enumeration of SAM Accounts
  ,"MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymous=4,1" # Network Access: Do not allow Anonymous Enumeration of Accounts and Shares
  ,"MACHINE\System\CurrentControlSet\Control\Lsa\LimitBlankPasswordUse=4,1" # Accounts: Limit local account use of blank passwords to console logon
  #,"MACHINE\System\CurrentControlSet\Control\Lsa\CrashOnAuditFail=4,0" # Audit: Shut Down system immediately if unable to log security alerts
  ,'MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AllocateDASD=1,"0"' # Devices: Allowed to format and eject removable media: Administrators
  ,'MACHINE\System\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers\AddPrinterDrivers=4,1' # Devices: Prevent users from installing printer drivers: Enabled

)

# PCI 8.1.2 Control addition, deletion, and modification of user IDs, credentials, and other identifier objects - Audit Account Management
$pci812_lsp_eventAudit = @(
  'AuditAccountManage = 3'
)

# PCI 8.1.4
#   Users not logged in past 7 or more days
#   Users logged off 30 days ago.
#   Users KickedOff more than a week ago
# Todo: implement check for user logins (or just rely on Tenable's audit)

# PCI 8.1.6 Limit repeated access attempts by locking out the user ID after not more than six attempts
$pci816_lsp_systemAccess = @(
  'LockoutBadCount = 6'
)

# PCI 8.1.7 Set the lockout duration to thirty minutes
$pci817_lsp_systemAccess = @(
  'ResetLockoutCount = 30'
)

# PCI 8.2.3 Require a minimum password length of at least seven characters 
# NOTE: This setting has been configured to surpass the PCI recommendation
$pci823_lsp_systemAccess = @(
  'MinimumPasswordLength = 12'
)

# PCI 8.2.4 Change user passwords at least every 90 days
$pci824_lsp_systemAccess = @(
  'MaximumPasswordAge = 90'
)

# PCI 8.2.5 Configure system security parameters to prevent misuse - Password History: 4 passwords remembered
$pci825_lsp_systemAccess = @(
  'PasswordHistorySize = 4'
)

# PCI 10.2.2 All actions taken by any individual with root or administrative privileges
$pci1022_lsp_eventAudit = @(
  'AuditLogonEvents = 3' # Audit Logon Events: Success and Failure
  ,'AuditAccountLogon = 3' # Audit Account Logon Events: Success and Failure
)

# PCI 10.2.7 Creation and deletion of system-level objects - Audit Object Access: Success and Failure
$pci1027_lsp_eventAudit = @(
  'AuditObjectAccess = 3'
)

# PCI 10.4 Synchronize all critical system clocks and times - Maximum tolerance for computer clock synchronization
# Only implemented at the domain controller level.
$pci104_lsp_kerberosPolicy = @(
  'MaxClockSkew = 5'
)

# PCI 10.5.1 Limit viewing of audit trails to those with a job-related need
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Application -Name RestrictGuestAccess -Value 1 # Application Log Restrict Guest Access: Enabled
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Security -Name RestrictGuestAccess -Value 1 # Security Log Restrict Guest Access: Enabled
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\System -Name RestrictGuestAccess -Value 1 # System Log Restrict Guest Access: Enabled

# PCI 10.7 Retain audit trail history for at least one year
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Application -Name Retention -Value 365 # Retain application log
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Security -Name Retention -Value 365 # Retain security log
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\System -Name Retention -Value 365 # Retain system log

# Get all local security policy variables
$lsp_eventAudit = Get-Variable | where {$_.Name -like "*lsp_eventAudit*" -and $_.Value -notlike "*System.Management*" }
$lsp_kerberosPolicy = Get-Variable | where {$_.Name -like "*lsp_kerberosPolicy*" -and $_.Value -notlike "*System.Management*"}
$lsp_registryValues = Get-Variable | where {$_.Name -like "*lsp_registryValues*" -and $_.Value -notlike "*System.Management*"}
$lsp_systemAccess = Get-Variable | where {$_.Name -like "*lsp_systemAccess*" -and $_.Value -notlike "*System.Management*"}


$lsp = @("[Unicode]","Unicode=yes") + @("[System Access]") + $lsp_systemAccess.Value + @("[Event Audit]") + $lsp_eventAudit.Value + @("[Kerberos Policy]") + $lsp_kerberosPolicy.Value + @("[Registry Values]") + $lsp_registryValues.Value
$lsp = $lsp + @("[Version]",'signature="$CHICAGO$"','Revision=1')
$lsp | out-file "$env:temp\secedit.inf"
Remove-Item "$env:windir\secedit.sdb" -ErrorAction SilentlyContinue
secedit /import /db "$env:windir\secedit.sdb" /cfg "$env:temp\secedit.inf" /verbose
secedit /configure /db "$env:windir\secedit.sdb" /cfg "$env:temp\secedit.inf" /verbose