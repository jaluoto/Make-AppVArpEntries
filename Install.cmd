set CONTENTDIR=%~dp0
set INSTALLDIR=C:\scripts
md "%INSTALLDIR%"
xcopy "%CONTENTDIR%Make-AppVArpEntries.ps1" "%INSTALLDIR%\"
schtasks.exe /Create /XML "%CONTENTDIR%Make-AppVArpEntries Event Task.xml" /TN "Make-AppVArpEntries Event Task"
