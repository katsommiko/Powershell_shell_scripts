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
 
 
Write-host "Please Wait While Removing  Outbound Connector : " -ForegroundColor Yellow -NoNewline
 
Try
{
    Get-OutboundConnector | Remove-OutboundConnector -Confirm:$false -ErrorAction stop
    Write-Host "Completed" -ForegroundColor Green	 
	   Start-Sleep -s 5
}catch
{
    Write-Host "Failed" -ForegroundColor Red
	 Start-Sleep -s 5
}
 
 
 Disconnect-ExchangeOnline -Confirm:$false