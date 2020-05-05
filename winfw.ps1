# Script to check windows firewall status and to disable if enabled
#  version 2.0

function Disable-WindowsFirewall
{
    # Check if the firewall enabled status is true on any profile, if so, set to false

    $firewallstatus = Get-NetFirewallProfile | Select-Object Name,Enabled

    if ($firewallstatus.Enabled -eq 'False')
    {
        Write-Host "Windows Firewall is disabled. No action required." -ForegroundColor Green
    }
    elseif ($firewallstatus.Enabled -eq 'True')
    {
        Write-Host "Windows firewall is enabled. Disabling ..." -ForegroundColor Yellow
        try
        {
        Set-NetFirewallProfile -All -Enabled False

        }
        catch [System.IO.IOException]
        {
            Write-Host "An error occurred:"
            Write-Host $_
        }
    }
}
Disable-WindowsFirewall

$verify = Get-NetFirewallProfile | Select-Object Name,Enabled | Write-Host -ForegroundColor Cyan