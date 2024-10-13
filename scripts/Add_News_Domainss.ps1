param ($UserName, $Password)
		
	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)

function getRandomString($lenght) {
	return -join ((65..90) + (97..122) | Get-Random -Count $lenght | % {[char]$_})
}

		Try	
            {
				Write-Host "Checking $User"  -ForegroundColor Yellow
				Connect-MsolService -Credential $UserCredential	-ErrorAction stop
				Connect-ExchangeOnline -Credential $UserCredential	-ErrorAction stop
           
          
 

 
 
    Try
    {
		
		$Domains = (Get-Content .\Domains\Domains.txt).Trim()
 
        Write-host "Creating NEW Sub-Domains for $User :" -ForegroundColor Yellow 
		
	$onmicrosoft = Get-AcceptedDomain | Where{$_.DomainName -like '*.onmicrosoft.com'} | Select DomainName
	
		foreach ($Domain in $Domains)
			{
			
			Try
			{
				
			 
			$sendDomains=$Domain.ToLower() 
			 Write-host "Creating NEW Domains  $sendDomains :" -ForegroundColor Yellow 
			$Recr =New-MsolDomain –Name $sendDomains -ErrorAction stop
		 $RecrodResult = Get-MsolDomainVerificationDns -DomainName $sendDomains -Mode DnsTxtRecord | Select Label,Text,ttl 
		 $msd = "$($sendDomains),$($RecrodResult.Text),$($onmicrosoft.DomainName)"
 	
		Add-Content ./Results/Add_News_Domains/News__Domains.txt $msd
		 Write-host "Success" -ForegroundColor Green	
		 
		  }catch {  Write-Host "Failed" -ForegroundColor Red  }
		  
		
			}
 
		Write-host "Success" -ForegroundColor Green			
        
        Start-Sleep -s 5
		 
    }catch
    {
        Write-Host "Failed" -ForegroundColor Red
	  Start-Sleep -s 5
    }
   }Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
Disconnect-ExchangeOnline -Confirm:$false


