$ConfirmPreference:"high"; 

set-location $env:TEMP; 

iwr https://aka.ms/install-powershell.ps1 -OutFile "install-powershell.ps1"; 

iwr 'https://github.com/azrasolutions/winpkgmgr/raw/main/Microsoft.VCLibs.x64.14.00.Desktop.appx' -OutFile 'Microsoft.VCLibs.x64.14.00.Desktop.appx'; 

iwr 'https://github.com/azrasolutions/winpkgmgr/raw/main/Microsoft.DesktopAppInstaller_2021.1207.634.0_neutral___8wekyb3d8bbwe.Msixbundle' -outfile 'Microsoft.DesktopAppInstaller_2021.1207.634.0_neutral___8wekyb3d8bbwe.Msixbundle'; 

iwr 'https://github.com/azrasolutions/winpkgmgr/raw/main/VCPlusPlus2015.appx' -outfile 'VCPlusPlus2015.appx';

iwr 'https://github.com/azrasolutions/winpkgmgr/raw/main/MicrosoftUIXML.appx' -outfile 'MicrosoftUIXML.appx';

powershell -file '.\install-powershell.ps1' -USEMSI -AddExplorerContextMenu -enablepsremoting -quiet; 

Function Test-PackageExistence
{$null}
	

try {

	Add-AppPackage -path '.\VCPlusPlus2015.appx';

	Add-AppPackage -path '.\Microsoft.VCLibs.x64.14.00.Desktop.appx'; 

	Add-AppPackage -path '.\MicrosoftUIXML.appx';
	
}

catch

{
	$specificexception = $Error.Exception.GetType().FullName
}

fianlly 

{
	

Install-PackageProvider -Name 'winget','nuget' -force; 

import-packageprovider 'winget','nuget' -force; 

Install-Module 'nuget','winget','powershellget' -force; 

Import-Module 'nuget','winget','packagemanagement' -force; 

Set-PackageSource -Name 'PSGallery' -Trusted -ForceBootStrap -providername 'powershellget';

}
