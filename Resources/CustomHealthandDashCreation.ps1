
while($true)
{
 CLS
$Server=$env:computername
#Ask for input from user
 write-output 'NOTE: Make sure the server name and destination names match what are in the metric browser or these templates will fail to connect(Case Sensitive)'
 $ServerInput = Read-Host -Prompt "Input your server name, LEAVE BLANK FOR: '$Server'"
 $TestDest = Read-Host -Prompt 'Input your test URL'
 $Server=$ServerInput

#Force local Hostname Variable if no input is detected
  If ($ServerInput -eq "") {$Server=$env:computername}
  
 New-Item -ItemType Directory -Force -Path ./CustomTemplates
 $DestAbbr=$TestDest.split(".")[-2]
 $DestAbbr=$DestAbbr.ToUpper() 
  (Get-Content IRIS-AlertTemplates.json -Raw) -replace 'DC2016-java-MA',$Server -replace 'www.google.com',$TestDest -replace 'Network Monitor Templates',"$TestDest Network Test"| Set-Content ./CustomTemplates/IRIS-CustomAlert-$DestAbbr.json
  (Get-Content IRIS-DashboardTemplate.json -Raw) -replace 'DC2016-java-MA',$Server -replace 'www.google.com',$TestDest | Set-Content ./CustomTemplates/IRIS-CustomDashboard-$DestAbbr.json
  
  write-output "Your templates have now been created in the /CustomTemplates folder"
  write-output "Press any key to create a new Destination template set, or close this window to end"
  pause
  }
