# ==========================================================
#  Marvin - Chen for new applications install
#
#  (C) Thomas Ljunggren, 2020-09-14
#
#  v 1.0 - First Version (2019-09-14)
#  v 2.0 - 365 Mail, Settings (2020-09-14)
# ==========================================================

#Mail SMTP Setup Section
$Subject = "Marvin - New Software Has Been Installed on $env:COMPUTERNAME" # Message Subject
$Server = "visolit-se.mail.protection.outlook.com" # SMTP Server
$From = "Marvin <lan.marvin@visolit.se>" # From whom we are sending an e-mail(add anonymous logon permission if needed)

$To = "lan.marvin@visolit.se" # To whom we are sending
$Pwd = ConvertTo-SecureString "enterpassword" -AsPlainText –Force #Sender account password
#(Warning! Use a very restricted account for the sender, because the password stored in the script will be not encrypted)
$Cred = New-Object System.Management.Automation.PSCredential("lan.marvin@visolit.se" , $Pwd) #Sender account credentials

$encoding = [System.Text.Encoding]::UTF8 #Setting encoding to UTF8 for message correct display

#Generates human readable userID from UserSID in log.
$UserSID = (Get-WinEvent -FilterHashtable @{LogName="Application";ID=11707;ProviderName="MsiInstaller"}).UserID.Value | select -First 1
$objSID = New-Object System.Security.Principal.SecurityIdentifier("$UserSID")
$UserID = $objSID.Translate([System.Security.Principal.NTAccount])

#Generates email body containing time created and message of application install.
$Body=Get-WinEvent -FilterHashtable @{LogName="Application";ID=11707;ProviderName='MsiInstaller'} | Select TimeCreated,Message | select-object -First 1

#Sending an e-mail.
Send-MailMessage -From $From -To $To -SmtpServer $Server -Body "$Body . Installed by: $UserID" -Subject $Subject -Encoding $encoding #-Credential $Cred 
