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
 
$rules = (Get-Content .\rules.txt).Trim()
 
$i =1
foreach ($rule in $rules)
{
 
 
 
    $conName = "R_$(Get-Random)_$i"
    Try
    {
        Write-host "Creating Rule $conName for message header $($rule) :" -ForegroundColor Yellow -NoNewline
       
	    $aa=New-TransportRule -Name $conName -RemoveHeader $rule  -SetAuditSeverity "High" -Mode Enforce -ErrorAction stop
		
        Write-host "Success" -ForegroundColor Green
		
		 
    }catch
    {
        Write-Host "Failed" -ForegroundColor Red
	 
    }
 
$i++
    

}
 Start-Sleep -s 5
Disconnect-ExchangeOnline -Confirm:$false