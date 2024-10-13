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
        Write-host "Valid Confirm NEW Sub-Domains for $User :" -ForegroundColor Yellow 
		$domains = Get-MsolDomain
	
		ForEach($domain_name in $domains){

		if($domain_name.Status -eq 'Unverified') {
        Try
			{
    Write-host "Confirm Records Domain $($domain_name.Name) :" -ForegroundColor Yellow -NoNewline
       $ff=Confirm-MsolDomain -DomainName $domain_name.Name -ErrorAction stop
            Write-host "Success" -ForegroundColor Green
		 
    }catch  { Write-Host "Failed" -ForegroundColor Red }

		 
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


