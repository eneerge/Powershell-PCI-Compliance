# Powershell-PCI-Compliance
This Powershell script can be used to configure the Local Security Policy on a Windows computer to meet PCI Compliance.

This script is based on the Tenable PCI Compliance audit file (https://www.tenable.com/downloads/audit)

NOTE: This will not get you to PCI Compliance. There are other things you must do to satisfy the requirements of PCI. However, this script can be used to help implement the policy settings in the Tenable audit file.


The following configuration has been commented out:
- PCI 2.2.4 Configure system security parameters to prevent misuse - Audit: Shut Down system immediately if unable to log security alerts

This is not something I wanted to implement in my environment.

