set INSTALLDIR=C:\scripts
schtasks.exe /Delete /TN "Intra\Make-AppVArpEntries Event Task" /F
del "%INSTALLDIR%\Make-AppVArpEntries.ps1"
