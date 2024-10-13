param ($UserName, $Password)
		
	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)

 

		Try	
            {
				Write-Host "Checking $User"  -ForegroundColor Yellow
				Connect-MsolService -Credential $UserCredential -ErrorAction stop
				Connect-ExchangeOnline -Credential $UserCredential -ErrorAction stop
            }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 

 
 
    Try
    {
		
           Write-host "Enabled DKIM Domain for  User $($User) :" -ForegroundColor Yellow
		 
		$domains = Get-MsolDomain		

		ForEach($domain_name in $domains.Name){
			
		if($domain_name -notlike '*onmicrosoft.com') {
			
				##If it doesn't exist - create new config
			if (!(get-dkimsigningconfig -Identity $domain_name -ErrorAction silent)) {
				Try
				{
				Write-host "- create new config DKIM For $($domain_name) :" -ForegroundColor Yellow -NoNewline
				$aa=New-DkimSigningConfig -DomainName $domain_name -KeySize 2048 -Enabled $true	 -ErrorAction stop
				  Write-host "Success" -ForegroundColor Green
		 
				}catch{
						Write-Host "Failed" -ForegroundColor Red
					}
				 
				}			
				##If DKIM exists but not already enabled, enable it
				if (((get-dkimsigningconfig -Identity $domain_name -ErrorAction silent).enabled) -eq $False) {
				Try
				{	
				Write-host "- enabled DKIM And Rotate For $($domain_name):" -ForegroundColor Yellow -NoNewline 
				$aa=Set-DkimSigningConfig -Identity $domain_name -Enabled $true  -ErrorAction stop
				$aa=Rotate-DkimSigningConfig -KeySize 2048 -Identity $domain_name -ErrorAction stop
				 Write-host "Success" -ForegroundColor Green
				 
				}catch{
						Write-Host "Failed" -ForegroundColor Red
					}
					
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


