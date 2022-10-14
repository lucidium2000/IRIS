#Set Destination and Hops - More destinations may benefit from less hops for better response times
$destlist='teams.office.com','www.google.com','outlook.office.com',"www.salesforce.com","www.servicenow.com"
# ,"www.splunk.com","www.atlassian.com"
$hops=10

#Static Variables
$loopvar = 1 
$phcreate = 0  

#Continuous Loop
while ($loopvar -le 1){



#For Loop based on destlist
foreach($dest in $destlist){
    $trace = Test-NetConnection "$dest" 
    $sourceaddress = $trace.SourceAddress.IPAddress
    $remoteaddress = $trace.RemoteAddress
    $routeinc=1
    
#DNS Measure     
    $dnsmeasurement = Measure-Command {Resolve-DnsName $dest} | Select-Object -ExpandProperty TotalMilliSeconds
        [long]$dnsformat=$dnsmeasurement*100

#Trace
$tracevar = (tracert -w 1 -d -h  $hops $dest)

while ($routeinc -lt $hops){
        [string]$traceoutput = $tracevar | sls -Pattern " $routeinc   "
        if ($traceoutput.Length -gt 0){
        $hoplist = ($traceoutput.substring(1,2))
        $ipindexlen = $traceoutput.Length
        $ipaddress = ($traceoutput.substring(32,([int]$ipindexlen-33)))
        

#Ping Average and Formatting
        $ping1 = ($traceoutput.substring(6,3))
            if ($ping1 -contains "  *"){$ping1 =$null}
            if ($ping1 -contains " <1"){$ping1 = "  1"}


        $ping2 = ($traceoutput.substring(15,3))
            if ($ping2 -contains "  *"){$ping2 =$null}
            if ($ping2 -contains " <1"){$ping2 = "  1"}


        $ping3 = ($traceoutput.substring(24,3))
            if ($ping3 -contains "  *"){$ping3 =$null}
            if ($ping3 -contains " <1"){$ping3 = "  1"}

           
        $pingarray=[int]$ping1,[int]$ping2,[int]$ping3       
        $pingAvg = ($pingarray | Measure-Object -Maximum)

        [int]$pingt = $pingavg.maximum
        write-output $pingt
       }

  if ($hoplist -contains " $($hoplist)"){$hoplist="0$($hoplist)"}
  if ($ipaddress -contains "Request timed out"){        $ipaddress = "UNKNOWN"}


    if ([long]$hoplist -lt 10){$hoplist=($hoplist).replace(" ","0")}
    write-output "name=Custom Metrics|Network|IRIS|$dest|Hop$($hoplist)|ResponseTime,value=$([int]$pingt),aggregator=OBSERVATION"
    

     write-output "name=Custom Metrics|Network|IRIS|$dest|Hop$($hoplist)|$ipaddress,value=$([int]$pingt),aggregator=OBSERVATION"
    
    $routeinc ++
    }

#Final Destination Stats
    $DestPing = (Test-Connection -computername $dest -Count 1 -ErrorAction SilentlyContinue) | Select-Object -ExpandProperty ResponseTime
    write-output "name=Custom Metrics|Network|IRIS|$dest|Final|ResponseTime,value=$DestPing,aggregator=OBSERVATION"
    write-output "name=Custom Metrics|Network|IRIS|$dest|Final|$RemoteAddress, value=$DestPing,aggregator=OBSERVATION"
    write-output "name=Custom Metrics|Network|IRIS|$dest|Final|DNSTime, value=$dnsformat"
    write-output "name=Custom Metrics|Network|IRIS|$dest|Final|SourceAddress|$sourceaddress, value=0"

    
    }
    }
