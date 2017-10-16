# Make-AppVArpEntries.ps1
# https://github.com/jaluoto
#
# Define Add/Remove Programs (ARP) registry entries for all installed App-V packages
# to enable legacy inventory and GUI-based removal

$UninstallPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

# Remove any orphaned entries from registry
Write-Output "Checking entries in registry..."
Get-ChildItem $UninstallPath -Name | Where-Object {$_ -like "AppVEntry_*"} | Foreach {
    Write-Output "Found entry for '$((Get-ItemProperty -Path $UninstallPath\$_).DisplayName)'"
    If (Get-AppvClientPackage -PackageId ($_.split("_"))[1] -VersionId ($_.split("_"))[2]) {
		Write-Output "- OK"
	} Else {
        Write-Output "- Not installed - removing $UninstallPath\$_"
        Remove-Item -Path "$UninstallPath\$_" -Recurse
    }
}

Write-Output ""

# Add entries for all installed AppV packages, if missing
Write-Output "Checking installed packages..."
Get-AppvClientPackage | Foreach {
    Write-Output "Found installed package '$($_.Name)'"
    $EntryPath = "$($UninstallPath)\AppVEntry_$($_.PackageId)_$($_.VersionId)"
    If (Test-Path $Entrypath) {
		Write-Output "- OK"
	} Else {
        Write-Output "- Adding entry to $EntryPath"
        New-Item -Path $EntryPath | Out-Null
        New-ItemProperty -Path $EntryPath -PropertyType String -Name DisplayName -Value "$($_.Name) (App-V)" | Out-Null
        New-ItemProperty -Path $EntryPath -PropertyType String -Name Publisher -Value "Added by Make-AppVArpEntries" | Out-Null
        New-ItemProperty -Path $EntryPath -PropertyType String -Name UninstallString -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command `"Write-Output 'Removing $($_.Name)...'; Remove-AppvClientPackage -PackageId $($_.PackageId) -VersionId $($_.VersionId); Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AppVEntry_$($_.PackageId)_$($_.VersionId)' -Recurse`"" | Out-Null
    }
}
