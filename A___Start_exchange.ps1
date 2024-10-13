#Set-ExecutionPolicy RemoteSigned
 
 
 
 
$packages = 'Add IPs Mutli Connectors',
			'Add IPs One Connectors',
			'Set IPs One Connectors',
			'Add IPs Mutli Connectors Multi-factor authentication',
			'Add IPs One Connectors Multi-factor authentication',
			'Remove IPs Connectors',
			'Remove IPs Connectors Multi-factor authentication',
            'Add Rules',
			'Add Rules  Multi-factor authentication',
			'Remove Rules',
			'Remove Rules Multi-factor authentication',
			'Add Outbound MX Connectors',
			'Add Outbound SmartHosts Connectors',
			'Remove Outbound Connectors',
			'Enabled Organization Customization',
			'Add Filter Policy IPS',
			'Disabled Anti-Spam BulkThreshold',
			'Add News Sub-Domains',
			'Add News Domains',
			'Valid Confirm News Domains',
			'Get Accepted Domains',
			'Remove Domains',
			'Enabled DKIM News Domains',
			'Disabled DKIM News Domains',
			'Get Accepted domains DKIM',
            'Enabled DKIM onmicrosoft.com',
			'Disabled DKIM onmicrosoft.com',
			'Create USER Account For SMTP',
			'Resets The Password for All Users',
			'Enabled SMTP',
			'Create New Mailbox 500 USER For SMTP',
			'Export Data Delivered',
			'Export Data Failed'
			
			
			
			
			
			
function Show-Menu
{
    Clear-Host
    Write-Host "**********************************************"
    Write-Host "LIST OF ACTIONS"

    # write the options using the array of packages

    for ($i = 0; $i -lt $packages.Count; $i++) 
    {
        # {0,10} means right align with spaces to max 2 characters
        Write-Host ('{0,10}. {1}' -f ($i + 1), $packages[$i])
    }

    Write-Host " q. Exit the script"
    Write-Host "*************************************************"
    Write-Host
}


function getRandomString($lenght) {
	return -join ((65..90) + (97..122) | Get-Random -Count $lenght | % {[char]$_})
}

function getAccounts {
	
	$lines = (Get-Content .\Compte_Office.txt).Trim()
	return $lines
}


 

# add inbound connector
function addInboundConnectors($user_name, $password,$chmine){
	 
		$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
   $AccesFile=$chmine+"\scripts\traiment_councteurs.ps1 $user_name $pass"
start powershell.exe $AccesFile

	
}
# add inbound connector
function addInboundConnectorsssl($user_name, $password,$chmine){
	 
		$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
   $AccesFile=$chmine+"\scripts\traiment_councteurs_ssl.ps1 $user_name $pass"
start powershell.exe $AccesFile

	
}
# add inbound connector
function addInboundoneConnectors($user_name, $password,$chmine){
	 
		$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
   $AccesFile=$chmine+"\scripts\traiment_councteurs_one.ps1 $user_name $pass"
start powershell.exe $AccesFile

	
}
# add inbound connector
function addInboundoneConnectorsexit($user_name, $password,$chmine){
	 
	 $passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
   $AccesFile=$chmine+"\scripts\traiment_councteurs_exit.ps1 $user_name $pass"
start powershell.exe $AccesFile

	
}
# add inbound connector
function addInboundoneConnectorsssl($user_name, $password,$chmine){
	 
		$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
   $AccesFile=$chmine+"\scripts\traiment_councteurs_one_ssl.ps1 $user_name $pass"
start powershell.exe $AccesFile

	
}

# add inbound connector
function removeInboundConnectors($user_name, $password,$chmine){
	 
		$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
   $AccesFile=$chmine+"\scripts\traiment_resett_councteurs.ps1 $user_name $pass"
start powershell.exe $AccesFile

	
}

# add inbound connector
function removeInboundConnectorsssl($user_name, $password,$chmine){
	 
		$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
   $AccesFile=$chmine+"\scripts\traiment_resett_councteurs_ssl.ps1 $user_name $pass"
start powershell.exe $AccesFile

	
}

# Set Hosted ConnectionFilterPolicy
function SetHostedConnectionFilterPolicy($user_name, $password,$chmine) {
	
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\traiment_add_saf.ps1 $user_name $pass"
start powershell.exe $AccesFile
	
}
# GEt Accepted Domains
function GEtAcceptedDomains($user_name, $password,$chmine) {
	
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\get_accepted_domains.ps1 $user_name $pass"
start powershell.exe $AccesFile
	
}

# GEt Accepted domains DKIM
function GEtAccepteddomainsDKIM($user_name, $password,$chmine) {
	
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\get_accepted_domains_dkim.ps1 $user_name $pass"
start powershell.exe $AccesFile
	
}
# Disabled Anti Spam
function DisabledAntiSpam($user_name, $password,$chmine) {
	
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\traiment_disable_anti.ps1 $user_name $pass"
start powershell.exe $AccesFile
	
}

# add outbound
function addOutboundConnector ($user_name, $password,$chmine){
	
		$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\add_OutboundConnector.ps1 $user_name $pass"
start powershell.exe $AccesFile
}

# add outbound SmartHosts
function addOutboundConnectorSmartHosts($user_name, $password,$chmine){
	
		$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\add_OutboundConnector_SmartHosts.ps1 $user_name $pass"
start powershell.exe $AccesFile
}

# remove outbound connector
function removeOutboundConnectors ($user_name, $password,$chmine){
	
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\remove_OutboundConnectors.ps1 $user_name $pass"
start powershell.exe $AccesFile 
	
}

# add DKIM
function addDKIM($user_name, $password,$chmine) {
	
 	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\addDKIM.ps1 $user_name $pass"
start powershell.exe $AccesFile
	
}

 

# remove DKIM
function removeDKIM {
 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\removeDKIM.ps1 $user_name $pass"
start powershell.exe $AccesFile	
	
	
}

# add Transport Rule
function addTransportRules($user_name, $password,$chmine) {
	
		$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\traiment_roules.ps1 $user_name $pass"
start powershell.exe $AccesFile
	

}
# add Transport Rule
function addTransportRulesssl($user_name, $password,$chmine) {
	
		$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
 
    $AccesFile=$chmine+"\scripts\traiment_roules_ssl.ps1 $user_name $pass"
start powershell.exe $AccesFile
	

}

# remove Transport Rule
function removeTransportRule($user_name, $password,$chmine){
	
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\traiment_resett_ruls.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile
	
}

# remove Transport Rule
function removeTransportRulessl($user_name, $password,$chmine){
	
 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\traiment_resett_ruls_sll.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile
	
}


# remove Transport Rule
function UserSmtps($user_name, $password,$chmine){
	
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\User_Smtps.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile
	
}

# add OrganizationCustomization
function EnableOrganizationCustomization($user_name, $password,$chmine) {
	
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\traiment_enable_organizationcustomization.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}

# add ResetsAllPasswordUsers
function ResetsAllPasswordUsers($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\Resets_Password_All_Users.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}

# Add News Domains
function AddNewsDomains($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\Add_News_Domains.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}
# Add News Domains
function AddNewsDomainss($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\Add_News_Domainss.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}
# Valid Confirm News Domains
function ValidConfirmNewsDomains($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\Valid_Confirm_News_Domains.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}

# Enabled DKM NEw Domains
function EnabledDKIMNewsDomains($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\Enabled_DKIM_News_Domains.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}

#Disabled DKIM News Domains
function DisabledDKIMNewsDomains($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\Disabled_DKIM_News_Domains.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}


# Remove Domains
function RemoveDomains($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\Remove_Domains.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}


# Export Data Delivered
function ExportDataDelivered($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\Export_Data_Delivered.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}

# Export Data Delivered
function NewMailbox ($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\mail_box.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}
# Export Data Delivered
function EnabledSMTP ($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\Enabled_SMTP.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}

# Export Data Failed
function ExportDataFailed($user_name, $password,$chmine) {
	 
	$passw = $password |ConvertTo-SecureString  -AsPlainText -Force
	$pass = ConvertFrom-SecureString -SecureString $passw
    $AccesFile=$chmine+"\scripts\Export_Data_Failed.ps1 $user_name $pass"
	
	start powershell.exe $AccesFile

}
 


while ($true) 
{
    Show-Menu

    $userInput = Read-Host "Select the action number(s) to be executed (space separated)"

    # test if the user wants to quit and if so, break the loop
    if ($userInput -eq 'q') { break }

	 
	$accounts = getAccounts
	
	ForEach($line in $accounts){
		$account = $line.Split(",")
		$user_name = $Account[0]
		$password = $Account[1]
		$chmine="C:\Users\Lenovo\Desktop\Scripts_PowerShell"
		Write-Host $user_name + " treatment...." -ForegroundColor Yellow
		 
		# Open Microsoft 365 Session
		# openSession $user_name $password
		
		foreach($input in $userInput.Split(' ')) {
			# test if the user entered a number between 1 and the total number of packages (inclusive)
			
			if ([int]::TryParse($input,[ref]$null) -and 1..$packages.Count -contains [int]$input) 
			{
				# here you install the chosen package using the array index number (= user input number minus 1)
				switch ($input)
				{
					1  {addInboundConnectors $user_name $password $chmine}
					2  {addInboundoneConnectors $user_name $password $chmine}
					3  {addInboundoneConnectorsexit $user_name $password $chmine}
					4  {addInboundConnectorsssl $user_name $password $chmine}
					5  {addInboundoneConnectorsssl $user_name $password $chmine}
					6  {removeInboundConnectors $user_name $password $chmine}
					7  {removeInboundConnectorsssl $user_name $password $chmine}
					8  {addTransportRules $user_name $password $chmine}
					9  {addTransportRulesssl $user_name $password $chmine}
					10  {removeTransportRule $user_name $password $chmine}
					11  {removeTransportRulessl $user_name $password $chmine}
					12  {addOutboundConnector $user_name $password $chmine}
					13  {addOutboundConnectorSmartHosts $user_name $password $chmine}
					14  {removeOutboundConnectors $user_name $password $chmine}
					15 {EnableOrganizationCustomization $user_name $password $chmine}
					16 {SetHostedConnectionFilterPolicy $user_name $password $chmine}
					17 {DisabledAntiSpam $user_name $password $chmine}
					18 {AddNewsDomains $user_name $password $chmine}
					19 {AddNewsDomainss $user_name $password $chmine}
					20 {ValidConfirmNewsDomains $user_name $password $chmine}
					21 {GEtAcceptedDomains $user_name $password $chmine}
					22 {RemoveDomains $user_name $password $chmine}
					23 {EnabledDKIMNewsDomains $user_name $password $chmine}
					24 {DisabledDKIMNewsDomains $user_name $password $chmine}
					25 {GEtAccepteddomainsDKIM $user_name $password $chmine}
					26 {addDKIM $user_name $password $chmine}
					27 {removeDKIM $user_name $password $chmine}
					28 {UserSmtps $user_name $password $chmine}
					29 {ResetsAllPasswordUsers $user_name $password $chmine}
					30 {EnabledSMTP $user_name $password $chmine}
					31 {NewMailbox $user_name $password $chmine}
					32 {ExportDataDelivered $user_name $password $chmine}
					33 {ExportDataFailed $user_name $password $chmine}
					
					


				
				
				}
				
			} else {
				$availableOptions = 1..$packages.Count -join ','
				Write-Host "Error in selection, choose $availableOptions or q"
			}
		}
		
		# Close Microsoft 365 Session
		 
	}
	
    $null = Read-Host "Press Enter to continue"
}
