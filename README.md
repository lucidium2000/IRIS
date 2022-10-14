# IRIS
AppDynamics-IRIS-MachineAgent-Extension (Internet Routing Inspection Service)

This extension allows customers to use the AppDynamics Machine Agent to setup network tests to remote destinations. By providing uptime and latency performance via ICMP and traceroute tests, the customer can gain insight into 3rd party dependency and route hop performance. All the metrics are baselined and can be setup to alert the user when performance deviates too far from the baseline.  

•	Limited to Windows machines with Powershell at the moment. Linux version in development.

•	Configuration is set via the IRIS.ps1 file on the top commented lines.

•	Hops per location can also be defined here, the default is 10, but can be set higher.

•	Due to the nature of how the tests work, please limit total hops to 50 per agent, for optimal performance. (For example, 5 tests at 10 hops ’5x10=50’, or 3 tests at 15 hops ’3x15=15’, etc.) Most locations will be under 20.

•	Bundled in the resource folder are templates for alerting and dashboards.

Configuration Steps:
1.	Install the AppDynamics Machine Agent
2.	Copy all files in this folder into a newly created ./monitors/IRIS folder
3.	configure this extension in the ./monitors/IRIS/IRIS.ps1 file by editing the top commented area with test locations and hop amounts.
Configuration File Details
IRIS.ps1

Only the top commented area should be modified
Example test to Google, Outlook(O365), Teams(O365) with 10 hops each:
$destlist='www.google.com','outlook.office.com',’teams.office.com’
$hops=10

Make sure to keep formatting the same. Be aware that the metric browser will create a new folder for each test in: Custom Metrics/Network/IRIS/ under the name of the server running the machine agent. There will be a folder for each hop named accordingly with a new metric called ResponseTime for each minute, with a metric folder denoting the IP of the hop to be used with further investigation.
This alone will give enough data for analysis. But for a visual representation, you can create dashboards with these custom metrics. Some templates are provided via the Resources folder. The provided dashboard relies on health rules that should be created first. 

To retrofit the health alerts and dashboard to your tests, go to the resources folder and run the CustomHealthandDashCreation.ps1 script in the ./monitors/IRIS/resources folder.
It will output 2 files, 1 for the HealthTemplates and another for the Dashboard. Import health rules first into the Server and Infrastructure category. Then Import Dashboard file accordingly.  
