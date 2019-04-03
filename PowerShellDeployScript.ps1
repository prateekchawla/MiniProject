
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
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    #Build url to test
	       $port = "8080"
	       $url = ""
	       $recipients = "prateek.chawla@elephant.com,prateek.chawla@inspopindia.com"
	       echo "URL to test : http://myfirstazurewebsiteadmiral.azurewebsites.net" 
	
	       $i = 0
	       $Content_Test = "Automation"
	       
	       $Response = Invoke-WebRequest -Uri http://myfirstazurewebsiteadmiral.azurewebsites.net -UseBasicParsing
	       $Content = $Response.Content
	
	       while(!($Content -match $Content_Test)){
	              if($i -eq 1){
	                     #it has been more than 1 minutes and the page never returned good content
	                     #send out an alert email
	                     echo "It has been 1 minutes without a good response..."
	                     echo "Aborting the job and sending an alert email"
	                     send-mailmessage -from "AutomationReportAgent@inspopindia.com" -to "prateek.chawla@elephant.com" -BodyAsHtml -subject "UnSuccessful Deployment of $WEBAPP_NAME " -body "<This is an automated message sent from Jenkins.</font></font>" -smtpServer EXCHANGE.InspopCorp.com
	                     exit 1
	              }
	              #page is still not returning the correct content
	              echo "Bad HTTP Content Response"
	              echo "Sleeping 1 minute..."
	              Start-Sleep -s 60
	              $Response = Invoke-WebRequest -Uri http://myfirstazurewebsiteadmiral.azurewebsites.net -UseBasicParsing
	              $Content = $Response.Content
	              $i++
	       }
	
	       #page has returned the correct content
	       echo "Good HTTP Content"
               send-mailmessage -from "AutomationReportAgent@inspopindia.com" -to "prateek.chawla@elephant.com" -BodyAsHtml -subject "Successful Deployment of $WEBAPP_NAME " -body "<This is an automated message sent from Jenkins.</font></font>" -smtpServer EXCHANGE.InspopCorp.com
 
echo http://$WEBAPP_NAME.azurewebsites.net
