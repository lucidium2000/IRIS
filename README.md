# IRIS
AppDynamics-IRIS-MachineAgent-Extension (Internet Routing Inspection Service)

This extension allows customers to use the AppDynamics Machine Agent to setup network tests to remote destinations. By providing uptime and latency performance via ICMP and traceroute tests, the customer can gain insight into 3rd party dependency and route hop performance. All the metrics are baselined and can be setup to alert the user when performance deviates too far from the baseline.  

•	Limited to Windows machines with Powershell at the moment. Linux version in development.

•	Configuration is set via the IRIS.ps1 file on the top commented lines.

•	Due to the nature of how the tests work, please limit to 5 total tests per agent.

•	Bundled in the resource folder are templates for alerting and dashboards.

Configuration Steps:
1.	Install the AppDynamics Machine Agent
2.	Copy all files in this folder into a newly created ./monitors/IRIS folder
3.	configure this extension in the ./monitors/IRIS/IRIS.ps1 file by editing the top commented area with test locations and hop amounts.
Configuration File Details
IRIS.ps1

Only the top commented area should be modified

Example test to Google, Outlook(O365), Teams(O365):
$destlist='www.google.com','outlook.office.com',’teams.office.com’

Make sure to keep formatting the same. Be aware that the metric browser will create a new folder for each test in: Custom Metrics/Network/IRIS/ under the name of the server running the machine agent. There will be a folder for each hop named accordingly with a new metric called ResponseTime for each minute, with a metric folder denoting the IP of the hop to be used with further investigation.
This alone will give enough data for analysis. But for a visual representation, you can create dashboards with these custom metrics. Some templates are provided via the Resources folder. The provided dashboard relies on health rules that should be created first. 

To retrofit the health alerts and dashboard to your tests:

1. Go to the resources folder and run the CustomHealthandDashCreation.ps1 script in the ./monitors/IRIS/resources folder.
2. It will output 2 files, 1 for the HealthTemplates and another for the Dashboard. 
3. Import health rules first into the Server and Infrastructure category. MAKE SURE THE HEALTH RULES ARE APPLIED AND SHOWING DATA BEFORE ADDING THE DASHBAORDS OR THEY WON'T LINK. Once the alerts are working, then Import Dashboard file accordingly.  
