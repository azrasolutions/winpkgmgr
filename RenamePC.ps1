$testfordomain = (Get-WMIObject win32_computersystem).PartOfDomain
#$isInDomain = (Get-WmiObject win32_computersystem).domain
$isindomain = 'nx.llllnnnn'

$getCurrentName = (Get-WmiObject win32_computersystem).Name
Write-Host -ForeGroundColor Yellow "Current PC Name is: $getCurrentName"`n

try { Test-Connection -ComputerName $isInDomain -Count 2 } catch { Write-Host -ForeGroundColor Red "Error: This PC is on the domain $isInDomain that cannot be accessed." `n "Is the user WFH without VPN connected?" } finally { write-host 'sumfing wong! :('; exit; }

$getnewname= Read-Host -Prompt "Please Enter PC's new name"



If ($testfordomain -eq $true)

{

Write-Host -foregroundcolor yellow "This PC is joined to the domain $isInDomain" 

$domaincreds = Get-Credential


Rename-Computer -NewName $getnewname -DomainCredential $domaincreds

}

else {Rename-Computer -NewName $getnewname}

