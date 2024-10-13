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
 
 
 $nameFile=$User.Split("@")
$fille=$nameFile[1]


    Try
    {
        Write-host "Get Accepted Domain for $User :" -ForegroundColor Yellow 
		
			$allDomain=$User+" =====> "
			$a=$GetAcceptedDomain=	Get-AcceptedDomain -ErrorAction stop | Select  Name 
			ForEach($domain_name in $GetAcceptedDomain.Name){
				
			$allDomain=$allDomain+" || "+$domain_name	
			
			 }
			
			Add-Content ./Results/Get_Accepted_Domain/Accepted_Domain.txt  $allDomain

        Write-host "Success" -ForegroundColor Green
		  Start-Sleep -s 5
    }catch
    {
        Write-Host "Failed" -ForegroundColor Red
	  Start-Sleep -s 5
    }


Disconnect-ExchangeOnline -Confirm:$false

