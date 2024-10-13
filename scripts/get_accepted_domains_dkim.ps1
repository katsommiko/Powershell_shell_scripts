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
        Write-host "Get Accepted DKIM Domain for $User :" -ForegroundColor Yellow 
		
				
			 $currentMessages= Get-DkimSigningConfig -ErrorAction stop | Where{$_.Enabled -like 'true'} | Select Domain 
			Add-Content ./Results/Get_Accepted_Domain_DKIM/$fille.txt  $currentMessages.Domain
			ForEach($domain_name in $currentMessages.Domain){
			$ssun=($domain_name).Split(".")	
			if($ssun.Count -eq 3){
				$file2=$ssun[1]+"."+$ssun[2]
				Add-Content ./Results/Get_Accepted_Domain_DKIM/Get_Domain_DKIM/$file2.txt  $domain_name
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