param ($UserName, $Password)
		
	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)



		Try	
            {
				Write-Host "Checking $User"  -ForegroundColor Yellow
					Connect-MsolService -Credential $UserCredential	-ErrorAction stop
				Connect-ExchangeOnline -Credential $UserCredential	-ErrorAction stop
			 
            }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red 
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 

 


    Try
    {
		 
        Write-host "Disabled DKIM  $User :" -ForegroundColor Yellow 
		
			 
      	 $domains = Get-MsolDomain
	
		ForEach($domain_name in $domains.Name){
		if($domain_name -like '*onmicrosoft.com') {
			$a=Set-DkimSigningConfig -Identity $domain_name -Enabled $false -ErrorAction stop
			 
		}
		
	}
	

        Write-host "Success" -ForegroundColor Green
		 Start-Sleep -s 5
		 
    }catch
    {
        Write-Host "Failed" -ForegroundColor Red
		 Start-Sleep -s 5
	 
    }

Disconnect-ExchangeOnline -Confirm:$false


