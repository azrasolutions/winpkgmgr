REM AZRA Automate Installer

powershell.exe -executionpolicy bypass -noninteractive -noprofile -command 

"Start-Transcript -Path '$env:temp\cwtracing.log'; New-Item -ItemType Directory -Path $env:SystemDrive\verytemp -Force; 

Set-Location $env:SystemDrive\verytemp; Invoke-WebRequest -Uri "https://github.com/azrasolutions/winpkgmgr/raw/main/Agent_Install.exe" -OutFile "./Agent_Install.exe"; 

Start-Process "./Agent_Install.exe" -ArgumentList "/s" -Wait;(get-service -DisplayName 'Azra Solutions Monitoring*').WaitForStatus('Running'); 

try {write-host -foregroundcolor yellow `n'Please wait 60 seconds, removing temp directories...';remove-item $env:systemdrive\verytemp -recurse -force -erroraction silentlycontinue} 

catch {remove-item $env:systemdrive\verytemp -recurse -force} finally {sleep 60; powershell.exe -executionpolicy bypass -noninteractive -noprofile -command "remove-item $env:systemdrive\verytemp -recurse -force"}"
