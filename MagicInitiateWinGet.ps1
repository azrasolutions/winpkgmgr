powershell -executionpolicy bypass -command { 

iwr -Uri 'https://raw.githubusercontent.com/azrasolutions/winpkgmgr/main/InstallWinGet.ps1' -OutFile $env:TEMP\InstallWinGet.ps1; 

sl $env:TEMP; & powershell -file .\InstallWinGet.ps1 }