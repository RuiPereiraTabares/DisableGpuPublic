[CmdletBinding()]
Param(
[switch] $disable
)



$DebugPreference = 'SilentlyContinue';
if ($PSCmdlet.MyInvocation.BoundParameters["Debug"].IsPresent) { $DebugPreference = 'Continue' }



$jsonfile = $env:AppData+"\Microsoft\Teams\desktop-config.json"



Write-Debug ("disable={0}" -f [bool]$disable)
Write-Debug ("jsonfile={0}" -f $jsonfile)



if (get-process -Name Teams -ErrorAction SilentlyContinue) {
Write-Host -ForegroundColor Red "Teams cannot be in memory. Please quit Teams and try again."
Exit
}



if (Test-Path $jsonfile) {
Write-Debug ("File exists.")
$json = Get-Content $jsonfile | ConvertFrom-Json
Write-Debug ("disableGpu={0}" -f [bool]$json.appPreferenceSettings.disableGpu)



if ($json.appPreferenceSettings.disableGpu -eq $False) {
$json.appPreferenceSettings.disableGpu = $True
$json | ConvertTo-Json | Out-File $jsonfile -Encoding ASCII
Write-Debug ("File modified.")
}
}
