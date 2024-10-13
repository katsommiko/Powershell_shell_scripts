param ($UserName, $Password)

	$User = $UserName
   $password =  ConvertTo-SecureString -String $Password
    $UserCredential = New-Object System.Management.Automation.PSCredential ($User, $password)



		Try	
            {
				Write-Host "Checking $User"  -ForegroundColor Yellow
				Connect-ExchangeOnline -Credential $UserCredential -ErrorAction stop
	 
        
 
$connectorNames = Get-InboundConnector  | Where{$_.Enabled -eq 'True'} | Select Name
 $index=0
$IPs = (Get-Content .\ips_Class.txt ).Trim()
foreach ($connectorName in $connectorNames.Name)
 
 {
if ($index -eq 0) {

$connector = Get-InboundConnector -Identity $connectorName -ErrorAction SilentlyContinue

  if ($connector) {
    if ($index -eq 0) {

     Try
    {
          
        $connector.SenderIPAddresses += $IPs
        Write-Host "Success: IP address to existing $connectorName." -ForegroundColor Yellow -NoNewline
       $aa= Set-InboundConnector -Identity $connectorName -SenderIPAddresses $connector.SenderIPAddresses -ErrorAction stop | Out-Null
        
         Write-host "Success" -ForegroundColor Green

       $index=1
      }catch
    {
        Write-Host "Failed" -ForegroundColor Red
	 
    } 




        }
   
    }


     }
     
  }
Start-Sleep -s 3
    }
            Catch
            {
                Write-Host "Login Failed $User" -ForegroundColor Red
                
				 
                Get-PSSession | Remove-PSSession
                Add-Content ./Results/Login_Failed.txt "$User"
            }
 
Disconnect-ExchangeOnline -Confirm:$false
