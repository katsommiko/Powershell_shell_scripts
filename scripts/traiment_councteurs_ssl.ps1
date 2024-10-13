param ($UserName, $Password)

	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)



		Try	
            {
				Write-Host "Checking $User"  -ForegroundColor Yellow
				Connect-ExchangeOnline -UserPrincipalName  $UserName -ErrorAction stop
	 
            }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 
 
$IPs = (Get-Content .\ips.txt).Trim()
 
 
$i =1
foreach ($IPSS in $IPs)
{
 

 
    $conName = "$(Get-Random)_$(Get-Random)_$i"
 
    Try
    {
        Write-host "Creating connector $conName for IP Address $($IPSS) :" -ForegroundColor Yellow -NoNewline
        $aa=New-InboundConnector -Name $conName -Enabled $true -ConnectorType "OnPremises"  -SenderDomains * -RestrictDomainsToIPAddresses $true -RequireTls $false -SenderIPAddresses $IPSS -ErrorAction stop | Out-Null

        Write-host "Success" -ForegroundColor Green
	
    }catch
    {
        Write-Host "Failed" -ForegroundColor Red
	 
    }
 
$i++
 

}
Start-Sleep -s 5
Disconnect-ExchangeOnline -Confirm:$false
