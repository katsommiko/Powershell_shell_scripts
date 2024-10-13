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
        Write-host "Enabled DKIM Domain for  onmicrosoft.com:" -ForegroundColor Yellow 
		
			 
      	 $domains = Get-MsolDomain
	
	ForEach($domain_name in $domains.Name){
		if($domain_name -like '*onmicrosoft.com') {
			
##If DKIM exists but not already enabled, enable it
if (((get-dkimsigningconfig -Identity $domain_name -ErrorAction silent).enabled) -eq $False) {
	Write-host "If DKIM doesn't exist - create new config For onmicrosoft.com :" -ForegroundColor Yellow -NoNewline
	$b=set-dkimsigningconfig -Identity $domain_name -Enabled $true -ErrorAction stop
	 Write-host "Success" -ForegroundColor Green
	}
##If it doesn't exist - create new config
if (!(get-dkimsigningconfig -Identity $domain_name -ErrorAction silent)) {
	
	Write-host "If DKIM exists but not already enabled  For onmicrosoft.com :" -ForegroundColor Yellow -NoNewline 
	$a=New-DkimSigningConfig -DomainName $domain_name -Enabled $true -ErrorAction stop
	Rotate-DkimSigningConfig -KeySize 2048 -Identity $domain_name -ErrorAction stop
	Write-host "Success" -ForegroundColor Green
	 
	}
		 
			
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


