$logName = '$env:TEMP\cwtrace.log'
$logPath = "cwtrace.log"
$tempdir = pwd

write-host -foregroundcolor Yellow "`nSuccessfully started logging to" $logPath" in" $tempdir`n

Start-Transcript -Path $env:TEMP\cwtrace.log

# New-Item -ItemType Directory -Path $env:SystemDrive\verytemp -Force; 

Set-Location $env:TEMP; 

write-host -foregroundcolor Yellow "`nPlese wait, downloading installer..."`n

Invoke-WebRequest -Uri "https://github.com/azrasolutions/winpkgmgr/raw/main/Agent_Install.exe" -OutFile "./Agent_Install.exe"; 

if (test-path Agent_Install.exe) { write-host -foregroundcolor green "`nPlese wait, installing CW Automate..."`n}

write-host -foregroundcolor Green "`nFile downloaded, beginning install..."`n

Start-Process "./Agent_Install.exe" -ArgumentList "/s" -Wait; 

(get-service -DisplayName 'Azra Solutions Monitoring*').WaitForStatus('Running')

write-host -foregroundcolor Yellow "`nWaiting for successful install notification..."`n

write-host -foregroundcolor yellow `n'Please wait 60 seconds, removing temp directories...'`n;

try {remove-item $env:TEMP\Agent_Install.exe -force -erroraction silentlycontinue} 

catch {remove-item $env:systemdrive\verytemp -recurse -force} finally {powershell.exe -executionpolicy bypass -noninteractive -noprofile -command "remove-item $env:TEMP\Agent_Install.exe -force"}