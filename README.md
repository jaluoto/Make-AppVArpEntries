# Make-AppVArpEntries
A PowerShell script to create Uninstall registry entries for installed App-V packages. 

Makes App-V packages visible and uninstallable from the Programs and Features a.k.a Add/Remove Programs a.k.a ARP window.

## What's the use case?

* You use a software inventory tool that relies on Uninstall registry entries (for example SCCM Hardware Inventory) and want App-V packages included.
* You want to enable admins without PowerShell skills to be able to uninstall App-V packages from the familiar Programs and Features menu.

## How to use

1. Run Make-AppVArpEntries.ps1 manually in elevated session or
2. Use the included installer to create a Scheduled Task that triggers the script automatically after each installation or removal of an App-V package.

