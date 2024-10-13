param ($UserName, $Password)
		
	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)



		Try	
            {
				Write-Host "Checking $User"  -ForegroundColor Yellow
				Connect-ExchangeOnline -Credential $UserCredential -ErrorAction stop
			 
            }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 

 
$RecipientDomains = (Get-Content .\OutboundConnector\Recipient_Domains.txt ).Trim()
$ValidateOutboundConnector = (Get-Content .\OutboundConnector\Validate_TEST_OutboundConnector.txt ).Trim()
$SmartHosts = (Get-Content .\OutboundConnector\OutboundConnector_SmartHosts.txt ).Trim()
    Try
    {
		 
        Write-host "Creating OutboundConnector SmartHosts for $User :" -ForegroundColor Yellow 
			$conName = "Host_$(Get-Random)_$(Get-Random)"
			$hh=New-OutboundConnector -Name "$conName" -RecipientDomains $RecipientDomains -TlsSettings CertificateValidation -ConnectorType Partner -SmartHosts $SmartHosts   -UseMXRecord:$false -Confirm:$false -ErrorAction stop
			Write-host "Success" -ForegroundColor Green
			Write-host "Validate TEST Outbound Connector SmartHosts  $ValidateOutboundConnector :" -ForegroundColor Yellow 
			Start-Sleep -s 2
			$ll=Validate-OutboundConnector -Identity "$conName" -Recipients $ValidateOutboundConnector -Confirm:$false -ErrorAction stop
			$ll=Set-OutboundConnector -Identity "$conName" -IsValidated $true -LastValidationTimestamp (Get-Date).ToUniversalTime() -ValidationRecipients $ValidateOutboundConnector -ErrorAction stop
		Write-host "Success" -ForegroundColor Green	
			 Start-Sleep -s 5
       
     
		 
    }catch
    {
        Write-Host "Failed" -ForegroundColor Red
		 Start-Sleep -s 5
	 
    }

Disconnect-ExchangeOnline -Confirm:$false


