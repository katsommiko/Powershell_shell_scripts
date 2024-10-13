param ($UserName, $Password)
		
	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)



		Try	
            {
				Write-Host "Checking $User"  -ForegroundColor Yellow
				Connect-ExchangeOnline -Credential $UserCredential	-ErrorAction stop
			 
            }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 

$IPs = (Get-Content .\ips.txt ).Trim()




    Try
    {
        Write-host "Creating Hosted Connection Filter Policy for ALL IP Address :" -ForegroundColor Yellow 
		
			 
        	$a=Set-HostedConnectionFilterPolicy -Identity Default -IPAllowList $IPs -EnableSafeList:$true  -ErrorAction stop
		
        Write-host "Success" -ForegroundColor Green
		Write-host "Please wait while Disabiled Anti-spam BulkThreshold : " -ForegroundColor Yellow -NoNewline
    $b=Set-HostedContentFilterPolicy -Identity "Default" -MakeDefault:$false -Confirm:$false   -BulkThreshold 1 -MarkAsSpamBulkMail "Off" -ErrorAction stop
    Write-Host "Success" -ForegroundColor Green
		  Start-Sleep -s 5
    }catch
    {
        Write-Host "Failed" -ForegroundColor Red
	  Start-Sleep -s 5
    }


Disconnect-ExchangeOnline -Confirm:$false

