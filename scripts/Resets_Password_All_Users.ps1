param ($UserName, $Password)
		
	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)
 

		Try	
            {
				Write-Host "Checking $User"  -ForegroundColor Yellow
				Connect-MsolService -Credential $UserCredential	-ErrorAction stop
			 
            }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 


$EmailUSers=Get-MsolUser
$newsPassowrd="Skalipan33@"
    Try
    {
        Write-host "Resets the Password for All user Account $User :" -ForegroundColor Yellow 
	foreach ($Email in $EmailUSers) { 

		Try
			{
		 Write-host "Reset the Password for   $Email.UserPrincipalName :" -ForegroundColor Yellow  
		$currentMessages = Set-MsolUserPassword -UserPrincipalName $Email.UserPrincipalName -NewPassword $newsPassowrd -ForceChangePassword:$false -ErrorAction stop
 
		$result= $Email.UserPrincipalName+","+$newsPassowrd
		Add-Content ./Results/Resets_Password_All_Users/Resets_Password_All_Users.txt $result
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


Disconnect-ExchangeOnline -Confirm:$false

