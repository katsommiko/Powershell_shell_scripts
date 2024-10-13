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

    Try
    {
		Try
			{
        Write-host "Creating OutboundConnector MX for $User :" -ForegroundColor Yellow 
			$conName = "con_$(Get-Random)_$(Get-Random)"
			$rzz=New-OutboundConnector -Name "$conName" -RecipientDomains $RecipientDomains -TlsSettings CertificateValidation -ConnectorType Partner -UseMXRecord:$true -ErrorAction stop
			Write-host "Success" -ForegroundColor Green
			Write-host "Validate TEST Outbound Connector MX  $ValidateOutboundConnector :" -ForegroundColor Yellow 
			Start-Sleep -s 2
			$rk= Validate-OutboundConnector -Identity "$conName" -Recipients $ValidateOutboundConnector -ErrorAction stop
		Write-host "Success" -ForegroundColor Green			
		 Start-Sleep -s 5
	}catch {  Write-Host "Failed" -ForegroundColor Red 
	 Start-Sleep -s 5
	}
       
		 
    }catch
    {
        Write-Host "Failed" -ForegroundColor Red
	  Start-Sleep -s 5
    }


Disconnect-ExchangeOnline -Confirm:$false

