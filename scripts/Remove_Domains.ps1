param ($UserName, $Password)
		
	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)



		Try	
            {
				Write-Host "Checking $User"  -ForegroundColor Yellow
				Connect-MsolService -Credential $UserCredential -ErrorAction stop
			 
            }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 

 


    Try
    {
		 
        Write-host "Remove DKIM Domain for  $User :" -ForegroundColor Yellow 
		
			 
		$domains = Get-MsolDomain
	
		ForEach($domain_name in $domains.Name){

		if($domain_name -notlike '*onmicrosoft.com') {
    
			Try
             {
   
             Write-host "Remove Domain $($domain_name) :" -ForegroundColor Yellow -NoNewline

			    $aa=Remove-MsolDomain -DomainName $domain_name -Force -ErrorAction stop
              Write-host "Success" -ForegroundColor Green
		 
             }catch {  Write-Host "Failed" -ForegroundColor Red }
		
        
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


