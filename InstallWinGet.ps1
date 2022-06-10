set-location $env:TEMP; 

iwr https://aka.ms/install-powershell.ps1 -OutFile "install-powershell.ps1"; 

iwr 'https://github.com/azrasolutions/winpkgmgr/raw/main/Microsoft.VCLibs.x64.14.00.Desktop.appx' -OutFile 'Microsoft.VCLibs.x64.14.00.Desktop.appx'; 

iwr 'https://github.com/azrasolutions/winpkgmgr/raw/main/Microsoft.DesktopAppInstaller_2021.1207.634.0_neutral___8wekyb3d8bbwe.Msixbundle' -outfile 'Microsoft.DesktopAppInstaller_2021.1207.634.0_neutral___8wekyb3d8bbwe.Msixbundle'; 

iwr 'https://github.com/azrasolutions/winpkgmgr/raw/main/VCPlusPlus2015.appx' -outfile 'VCPlusPlus2015.appx';

iwr 'https://github.com/azrasolutions/winpkgmgr/raw/main/MicrosoftUIXML.appx' -outfile 'MicrosoftUIXML.appx';

powershell -file '.\install-powershell.ps1' -USEMSI -AddExplorerContextMenu -enablepsremoting -quiet; 


Function Gather-TempFiles

{	
	$bootstrapFiles = @()
	$bootstrapFiles = '.\Microsoft.DesktopAppInstaller_2021.1207.634.0_neutral___8wekyb3d8bbwe.Msixbundle','.\VCPlusPlus2015.appx','.\Microsoft.VCLibs.x64.14.00.Desktop.appx''.\MicrosoftUIXML.appx''.\install-powershell.ps1'

}

Function Delete-TempFiles

{
	ForEach ($file in $bootstrapFiles)
	
	{
		
	Remove-item -Include $file
	
	}
}	
	
try {

	Add-AppPackage -path '.\VCPlusPlus2015.appx';

	Add-AppPackage -path '.\Microsoft.VCLibs.x64.14.00.Desktop.appx'; 

	Add-AppPackage -path '.\MicrosoftUIXML.appx';
	
}

catch

{
	
	$vclibs = Get-AppxPackage -AllUsers | ? {($_.name -like 'Microsoft.VCLibs*') -and ($_.version -gt '14.0.30035.0') -or ($_.version -eq '14.0.30035.0') }
	$uiXAML = Get-AppxPackage -AllUsers | ? {($_.name -like 'Microsoft.UI.Xaml') -and ($_.version -gt '7.2203.17001.0') -or ($_.version -eq '7.2203.17001.0') }
	$pkgmgr = Get-AppxPackage -AllUsers | ? {$_.name -eq 'Microsoft.DesktopAppInstaller' }
	
	
	if ($vclibs -or $uiXAML -or $pkgmgr) { $ErrorActionPreference='SilentlyContinue' }

}	
	finally

{	

Install-PackageProvider -Name 'winget','nuget' -force;
import-packageprovider 'winget','nuget' -force; 

Install-Module 'nuget','winget','powershellget' -force; 

Import-Module 'nuget','winget','packagemanagement' -force; 

Set-PackageSource -Name 'PSGallery' -Trusted -ForceBootStrap -providername 'powershellget';

$flagReboot = 1;
Write-Output $_

Gather-TempFiles;
Delete-TempFiles;

Write-Warning -Message "Your PC needs to be rebooted. Please reboot ASAP."
}




