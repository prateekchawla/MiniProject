
$RepoPath = "https://github.com/prateekchawla/SecondGit"

$appID="717152e6-feef-4c22-904e-bad03901940d"
$password="/DJv.^g!_#Q|)II_[};-1$W/#-$>?r$dI/*&}*6"
$tenant="a26a5ff8-8542-4fff-b6de-bee30a6b56b7"
$RESOURCE_NAME="AzureResourceGroup"
$PLAN_NAME="AzurePlan"
$WEBAPP_NAME="MyFirstAzureWebsiteAdmiral"

az login --service-principal -u $appID --password $password --tenant $tenant
az group create --location westeurope --name $RESOURCE_NAME
az appservice plan create --name $PLAN_NAME --resource-group $RESOURCE_NAME --sku FREE
az webapp create --name $WEBAPP_NAME --resource-group $RESOURCE_NAME --plan $PLAN_NAME


az webapp deployment source config --name $WEBAPP_NAME --resource-group $RESOURCE_NAME --repo-url $RepoPath --branch master --manual-integration

    #Build url to test
	       $port = "8080"
	       $url = "http://$WEBAPP_NAME.azurewebsites.net"
	       $recipients = "prateek.chawla@elephant.com"
	       echo "URL to test : $url" 
	
	       $i = 0
	       $Content_Test = "Automation"
	       
	       $Response = Invoke-WebRequest $url
	       $Content = $Response.Content
	
	       while(!($Content -match $Content_Test)){
	              if($i -eq 15){
	                     #it has been more than 15 minutes and the page never returned good content
	                     #send out an alert email
	                     echo "It has been 15 minutes without a good response..."
	                     echo "Aborting the job and sending an alert email"
	                     Copy-Item \\admiral.local\nonprod\billing\$ENVIRONMENT\logs\bclog-$ENVIRONMENT.log $WORKSPACE
	                     send-mailmessage -from "NoReply@Elephant.com" -to $recipients -BodyAsHtml -Priority High -Attachments "$WORKSPACE\bclog-$ENVIRONMENT.log" -subject "Unsuccessful GuideWire 9 BillingCenter $ENVIRONMENT Deployment" -body "<font face = Calibri>The newest code version has been deployed to the GW9 <b>BillingCenter</b> application in <b>$ENVIRONMENT</b>.<br><font color=red><b>BUT, the server is not returning the correct page content.<br>The BillingCenter application log at the time of this email is attached.<br>Please check the log for errors.</b></font><br><br>The list of the code changes included in this deployment is below:<br><font color=#21618C>$GitFileContent</font><br><br><font color=#626567>This is an automated message sent from Jenkins.</font></font>" -smtpServer mailrelay.elephant.com
	                     exit 1
	              }
	              #page is still not returning the correct content
	              echo "Bad HTTP Content Response"
	              echo "Sleeping 1 minute..."
	              Start-Sleep -s 60
	              $Response = Invoke-WebRequest $url
	              $Content = $Response.Content
	              $i++
	       }
	
	       #page has returned the correct content
	       echo "Good HTTP Content"
         
send-mailmessage -from "AutomationReportAgent@inspopindia.com" -to "prateek.chawla@elephant.com" -BodyAsHtml -subject "Successful Deployment of $WEBAPP_NAME " -body "<This is an automated message sent from Jenkins.</font></font>" -smtpServer EXCHANGE.InspopCorp.com
 
echo http://$WEBAPP_NAME.azurewebsites.net
