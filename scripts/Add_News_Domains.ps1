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
		
		$Domains = (Get-Content .\Sub_Domains\Sub_Domains.txt).Trim()
 
        Write-host "Creating NEW Sub-Domains for $User :" -ForegroundColor Yellow 
		
	$onmicrosoft = Get-AcceptedDomain | Where{$_.DomainName -like '*.onmicrosoft.com'} | Select DomainName
	
		foreach ($Domain in $Domains)
			{
			
			Try
			{
				
			$Aliasname=getRandomString 5
			$Aliasname=$Aliasname.ToLower() 
			$sendDomains=$Aliasname+"."+$Domain
			 Write-host "Creating NEW Sub-Domains  $sendDomains :" -ForegroundColor Yellow 
			$Recr =New-MsolDomain –Name $sendDomains -ErrorAction stop
		 $RecrodResult = Get-MsolDomainVerificationDns -DomainName $sendDomains -Mode DnsTxtRecord | Select Label,Text,ttl 
		 $msd = "$($Aliasname),$($Domain),$($RecrodResult.Text),$($onmicrosoft.DomainName)"
 	
		Add-Content ./Results/Add_News_Domains/News_Sub_Domains.txt $msd
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

   }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 
Disconnect-ExchangeOnline -Confirm:$false


