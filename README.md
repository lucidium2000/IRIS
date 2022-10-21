# IRIS
AppDynamics-IRIS-MachineAgent-Extension (Internet Routing Inspection Service)

This extension allows customers to use the AppDynamics Machine Agent for testing route performance data to remote destinations. By providing uptime and latency performance via ICMP and traceroute tests, this extension can help the user gain insight into 3rd party dependency network performance. The first 10 route hop metrics are baselined and can be setup to alert when connection performance deviates too far from the baseline.  

•	Limited to Windows machines with Powershell at the moment. Linux version in development.

•	Configuration is set via the IRIS.ps1 file on the top commented lines.

•	Due to the nature of how the tests work, please limit to 5 total tests per agent.

•	Bundled in the resource folder are templates for alerting and dashboards.

Configuration Steps:
1.	Install the AppDynamics Machine Agent
2.	Copy all files in this folder into a newly created ./monitors/IRIS folder
3.	Configure this extension in the ./monitors/IRIS/IRIS.ps1 file by editing the top commented area with test locations.

Only the top commented area should be modified

Example test to Google, Outlook(O365), Teams(O365):
$destlist='www.google.com','outlook.office.com',’teams.office.com’

Make sure to keep formatting the same. Be aware that the metric browser will create a new folder for each test in: Custom Metrics/Network/IRIS/ under the name of the server running the machine agent(Notate this name for use of the later mentioned creation scripts). 

There will be a folder for each hop named accordingly with a new metric called ResponseTime for each minute, with a metric folder denoting the IP of the hop to be used with further investigation.

Health Alerts and Route path dashboard templates can be created via provided script:

1. Go to the resources folder and run the CustomHealthandDashCreation.ps1 script in the ./monitors/IRIS/resources folder.*MAKE SURE ALL NAMES MATCH EXACTLY (Case Sensitive)*
2. It will output 2 files, 1 for the HealthTemplates and another for the Dashboard.(Under the ./CustomTemplates folder) 
3. Import health rules into the Alerting Templates
4. Apply the new template into the 'Server and Infrastructure category'. *MAKE SURE THE HEALTH RULES ARE APPLIED AND SHOWING DATA BEFORE ADDING THE DASHBAORDS OR THEY WON'T LINK*. Once the alerts are working, then Import Dashboard file accordingly. 
