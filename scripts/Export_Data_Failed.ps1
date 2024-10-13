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
$finachemin=$fille
#############
#region Customizable settings
#############
# We want to get emails until today
  # $endDate = "02/15/2023 23:59:00"
# And as many of them as possible = 10 days
# 10 days is maximum supported by the cmdlet
   # $startDate = "02/14/2023 00:01:00"
# We want to get emails until today
    $endDate = (Get-Date).Date
# And as many of them as possible = 10 days
# 10 days is maximum supported by the cmdlet
   $startDate = ($endDate).AddDays(-10)

 
# Let's specify maximum page size
$pageSize = 5000
# And max number of pages if we want to modify
$maxPage = 1000

# We want to log every X pages
# Set it to 1 to log every page
$logEveryXPages = 5

# And let's define where the results are saves
$outFilePath = $finachemin+"-$(Get-Date -Format "yyMMdd").txt"

#############
#endregion Customizable settings
#############

# Let's initialize a variable
$allMessages = @()

# We'll use splatting for readability
# And also because it's cool
$gmtParams = @{
  StartDate = $startDate
  EndDate = $endDate
  PageSize = $pageSize
  Page = 1
}

do {
  $gmtParams.Page = 1

  Write-Host "Starting message trace until $($gmtParams.EndDate) email : $($User)"

  do {
    # Logging
    if ($gmtParams.Page % $logEveryXPages -eq 0) {
      Write-Host "Processing page $($gmtParams.Page)"
    }
    
    $currentMessages = Get-MessageTrace @gmtParams -Status "Failed" | Group-Object -Property RecipientAddress | Select name
    $gmtParams.Page++
	Add-Content ./Results/Failed/$outFilePath $currentMessages.Name
    # We need to grab the timestamp for last occurence
    if ($gmtParams.Page -gt $maxPage -and $null -ne $currentMessages) {
      $gmtParams.EndDate = $currentMessages.Received | Sort-Object | Select-Object -First 1
    }

    # Let's add a short break so we're not throttled
    Start-Sleep -Seconds 1

  # The loop should end when there's no more messages
  # or when we reach last page
  } until ( $null -eq $currentMessages -or $gmtParams.Page -gt $maxPage )
# The outer loop should end when there's no more messages
} until ( $null -eq $currentMessages )

Disconnect-ExchangeOnline -Confirm:$false