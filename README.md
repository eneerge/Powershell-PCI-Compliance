# Powershell-PCI-Compliance
This Powershell script can be used to configure the Local Security Policy on a Windows computer to meet PCI Compliance.  
This script implements settings checked by the Tenable Windows PCI Compliance 3.0 audit file (https://www.tenable.com/downloads/audit).

NOTE: This will not get you to PCI Compliance. There are other things you must do to satisfy the requirements of PCI such as segmenting your PCI terminals into a different network. However, this script can be used to help implement the policy settings in the Tenable audit file. 

Link to the spec: https://www.pcisecuritystandards.org/documents/PCI_DSS_v3-2-1.pdf

----
  
  
After running the Tenable PCI compliance audit, the following should be the result:  
# PASSES
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service Alerter Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service AppMgr Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service Appmon Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service BINLSVC Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service CiSvc Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service ClipSrv Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service FAX Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service helpsvc Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service HTTPFilter Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service IISADMIN Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service LicenseService Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service MacFile Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service MacPrint Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service Messenger Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service mnmsrvc Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service MSFtpsvc Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service Netman Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service Ntfrs Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service NWCWorkstation Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service Pop3Svc Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service RasAuto Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service RasMan Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service RDSessMgr Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service RemoteRegistry Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service Remote_Storage_Server Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service Remote_Storage_User_Link Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service RpcLocator Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service SMTPSVC Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service SNMP Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service SNMPTRAP Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service Spooler Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service srvcsurg Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service TapiSrv Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service TermService Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service TFTPD Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service TlntSvr Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service W3SVC Disabled  
PCI 2.2.2 Disable all unnecessary and insecure services and protocols, Service WZCSVC Disabled  
PCI 2.2.4 Configure system security parameters to prevent misuse - Minimum Password Age: 1 day  
PCI 2.2.4 Configure system security parameters to prevent misuse - Network Access: Allow Anonymous SID/Name Translation: Disabled  
PCI 2.2.4 Configure system security parameters to prevent misuse - Network Access: Do not allow Anonymous Enumeration of SAM Accounts  
PCI 2.2.4 Configure system security parameters to prevent misuse - Network Access: Do not allow Anonymous Enumeration of Accounts and Shares  
PCI 2.2.4 Configure system security parameters to prevent misuse - Accounts: Guest Account Status: Disabled  
PCI 2.2.4 Configure system security parameters to prevent misuse - Accounts: Limit local account use of blank passwords to console logon  
PCI 2.2.4 Configure system security parameters to prevent misuse - Accounts: Rename Administrator Account: non-standard  
PCI 2.2.4 Configure system security parameters to prevent misuse - Accounts: Rename Guest Account: non-standard  
PCI 2.2.4 Configure system security parameters to prevent misuse - Devices: Allowed to format and eject removable media: Administrators  
PCI 2.2.4 Configure system security parameters to prevent misuse - Devices: Prevent users from installing printer drivers: Enabled  
PCI 8.1.2 Control addition, deletion, and modification of user IDs, credentials, and other identifier objects - Audit Account Management  
PCI 8.1.4 Users not logged in past 7 or more days.  
PCI 8.1.4 Users logged off 30 days ago.  
PCI 8.1.4 Users KickedOff more than a week ago  
PCI 8.1.6 Limit repeated access attempts by locking out the user ID after not more than six attempts  
PCI 8.1.7 Set the lockout duration to thirty minutes  
PCI 8.2.3 Require a minimum password length of at least seven characters  
PCI 8.2.4 Change user passwords at least every 90 days  
PCI 8.2.5 Configure system security parameters to prevent misuse - Password History: 4 passwords remembered  
PCI 10.2.2 All actions taken by any individual with root or administrative privileges - Audit Logon Events: Success and Failure  
PCI 10.2.2 All actions taken by any individual with root or administrative privileges - Audit Account Logon Events: Success and Failure  
PCI 10.2.7 Creation and deletion of system-level objects - Audit Object Access: Success and Failure  
PCI 10.5.1 Limit viewing of audit trails to those with a job-related need - Application Log Restrict Guest Access: Enabled  
PCI 10.5.1 Limit viewing of audit trails to those with a job-related need - Security Log Restrict Guest Access: Enabled  
PCI 10.5.1 Limit viewing of audit trails to those with a job-related need -  System Log Restrict Guest Access: Enabled  
PCI 10.7 Retain audit trail history for at least one year - Retention method for application log  
PCI 10.7 Retain audit trail history for at least one year - Retention method for security log  
PCI 10.7 Retain audit trail history for at least one year - Retention method for system log  

# FAILS
PCI 2.2.4 Configure system security parameters to prevent misuse - Audit: Shut Down system immediately if unable to log security alerts  
- This has been commented out in the script. Feel free to uncomment.

PCI 10.7 Retain audit trail history for at least one year - Retain application log  
PCI 10.7 Retain audit trail history for at least one year - Retain security log  
PCI 10.7 Retain audit trail history for at least one year - Retain system log  
  - These checks are looking for a value that is no longer valid in newer versions of Windows (Retain application log for x days). The replacement is to use a maximum file size with log rolling. I have implemented this in the script instead.  
  - In addition, to meet PCI 10.5.2 and 10.5.4 (which is not tested in the Tenable audit), you should use an external logging server (See Manage Engine EventLog Analyzer, Microsoft Sentinel, OSSEC, Splunk, Wazuh, etc.)

# WARNINGS
PCI 10.4 Synchronize all critical system clocks and times - Maximum tolerance for computer clock synchronization  
  - This configuration is only valid on a domain controller or possibly a domain controller environment. PCI Terminals should not be installed on domain controllers.
