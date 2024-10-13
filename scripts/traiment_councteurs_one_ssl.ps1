param ($UserName, $Password)
		
	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)



		Try	
            {
				Write-Host "Checking $User"  -ForegroundColor Yellow
				Connect-ExchangeOnline -UserPrincipalName  $UserName	-ErrorAction stop
				 
            }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 

$IPs = (Get-Content .\ips_Class.txt ).Trim()




$conName = "$(Get-Random)_1"

    Try
    {
        Write-host "Creating connector $User for ALL IP Address :" -ForegroundColor Yellow -NoNewline
        $aaa= New-InboundConnector -Name $conName -Enabled $true -ConnectorType "OnPremises"  -SenderDomains * -RestrictDomainsToIPAddresses $true -RequireTls $false -SenderIPAddresses $IPs  -ErrorAction stop
 
        Write-host "Success" -ForegroundColor Green
		  Start-Sleep -s 5
    }catch
    {
        Write-Host "Failed" -ForegroundColor Red
	  Start-Sleep -s 5
    }



Disconnect-ExchangeOnline -Confirm:$false