$WiFi = (netsh wlan show network  mode=bssid |  Select-Object -Skip  3).Trim()  | Out-String

$RegEx = @'

  (?x)

  SSID\s\d+\s:\s(?<SSID>[a-z0-9\-\*\.&_]+)\r\n

  Network\stype\s+:\s(?<NetworkType>\w+)\r\n

  Authentication\s+:\s(?<Authentication>[a-z0-9\-_]+)\r\n

  Encryption\s+:\s(?<Encryption>\w+)\r\n

  BSSID\s1\s+:\s(?<BSSID>(?:\w+:){5}\w+)\r\n

  Signal\s+:\s(?<Signal>\d{1,2})%\r\n

  Radio\stype\s+:\s(?<Radio>[a-z0-9\.]+)\r\n

  Channel\s+:\s(?<Channel>\w+)\r\n

'@ 

$Networks = $WiFi -split  "\r\s+\n" 

$WiFiNetworks = $Networks | ForEach {

    If ($_ -match $RegEx) {
  
        [pscustomobject]@{
    
            SSID =  $Matches.SSID
            NetworkType = $Matches.NetworkType
            AuthenticationType = $Matches.Authentication
            Encryption =  $Matches.Encryption
            BSSID1 =  $Matches.BSSID
            SignalPercentage = [int]$Matches.Signal
            RadioType =  $Matches.Radio
            Channel =  $Matches.Channel
        
            }
        
        }
  
    }
  
  $WiFiNetworks | Sort SignalPercentage -Descending 