param ($UserName, $Password)
		
	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)


			Try	
            {

				Write-Host "Checking $User"  -ForegroundColor Yellow
				Connect-ExchangeOnline -Credential $UserCredential -ErrorAction stop -ShowBanner:$false
	 
            }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 
 
function getRandomString($lenght) {
	return -join ((65..90) + (97..122) | Get-Random -Count $lenght | % {[char]$_})
}



$Alias=$User.Split("@")
$domain_accout=$Alias[1]
$time=0;
$timelong=0;
$poddpasss=(ConvertTo-SecureString -String 'pa687AZ@' -AsPlainText -Force)
    Try
    {
        Write-host "Creating All User SMTP for $User :" -ForegroundColor Yellow 
 


for($x=0; $x -lt 500; $x=$x+1){ 

		 Try	
            {
				
				$Aliasname=getRandomString 10
				$Aliasname=$Aliasname.ToLower() 
			 
	 
 	$currentMessages =New-Mailbox -Alias $($Aliasname) -Name "$($Aliasname)" -FirstName "$($Aliasname)" -LastName "$($Aliasname)" -DisplayName "$($Aliasname)" -MicrosoftOnlineServicesID "$($Aliasname)@fara.expert" -Password $poddpasss  -ResetPasswordOnNextLogon $false -ErrorAction stop | Select UserPrincipalName

		 
		$result=$currentMessages.UserPrincipalName+";pa687AZ@"
		Add-Content ./Results/ACOUNT_SMTP_USER/$domain_accout.txt $result
		 
		 }
            Catch
            {
             Write-host "Sleep 60" -ForegroundColor Green			
			 
           $x=$x-1
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


