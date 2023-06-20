$RepoPath = "https://github.com/prateekchawla/SecondGit"
$appID="cf1e7bb5-d72e-40e0-a9f1-376ff80fc836"
$password="lNjuMvj7evFl8Mp/jJ1dXMkzpevmz4Od1vwIT6uUIDQ="
$tenant="db0c5f88-2012-4148-8aed-ff42f535b57b"
$RESOURCE_NAME="AzureResourceGroup"
$PLAN_NAME="AzurePlan"
$WEBAPP_NAME="MyFirstAzureWebsiteAdmiral"
$EmailUsername = "prateek.chawla";
$EmailPassword = "Galaxyyoung123";
$FromEmail = "AutomationReportAgent@inspopindia.com";
$SMPTP_Server = "EXCHANGE.InspopCorp.com";
$ToEmail = "prateek.chawla@inspopindia.com";
###comment
	#Function to send Email using smtp 
function Send-ToEmail([string]$email , [string]$Subject , [string]$Body)
{
    $message = new-object Net.Mail.MailMessage;
    $message.From = $FromEmail;
    $message.To.Add($email);
    $message.Subject = $Subject;
    $message.Body = $Body;
    $smtp = new-object Net.Mail.SmtpClient($SMPTP_Server);
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($EmailUsername, $EmailPassword);
    $smtp.send($message);
 }

    #Create Azure resources
az login --service-principal -u $appID --password $password --tenant $tenant
az group create --location westeurope --name $RESOURCE_NAME
az appservice plan create --name $PLAN_NAME --resource-group $RESOURCE_NAME --sku FREE
az webapp create --name $WEBAPP_NAME --resource-group $RESOURCE_NAME --plan $PLAN_NAME

   #Deploy to Azure resource
az webapp deployment source config --name $WEBAPP_NAME --resource-group $RESOURCE_NAME --repo-url $RepoPath --branch master --manual-integration

   #Test content on website
	$url = "http://$WEBAPP_NAME.azurewebsites.net"
	$recipients = "prateek.chawla@elephant.com"
	echo "URL to test : $url" 
	$i = 0
	$Content_Test = "Automation"
	$Response = Invoke-WebRequest $url -UseBasicParsing
	$Content = $Response.Content
	
	  while(!($Content -match $Content_Test))
	    {
	           if($i -eq 2)
		   {
	               	     #it has been more than 1 minute and the page never returned good content
	                     #send out an alert email
	                     echo "It has been 1 minute without a good response..."
	                     echo "Aborting the job and sending an alert email"
	                     Send-ToEmail  -email $ToEmail -Subject "UnSuccessful Deployment of $WEBAPP_NAME" -Body "This is an Automated mail by Jenkins"
	                     exit 1
	              }
	              #page is still not returning the correct content
	              echo "Bad HTTP Content Response"
	              echo "Sleeping 30 SECONDS..."
	              Start-Sleep -s 30
	              $Response = Invoke-WebRequest $url -UseBasicParsing
	              $Content = $Response.Content
	              $i++
	       }
	       
	#page has returned the correct content
	echo "Good HTTP Content"
        Send-ToEmail  -email $ToEmail -Subject "Successful Deployment of $WEBAPP_NAME" -Body "This is an Automated mail by Jenkins"
  
  
#Check Http status code of website  
$HTTP_Status = curl.exe -s -o /dev/null -w '%{http_code}' $url 
If ($HTTP_Status -eq 200) {
   echo "Site is OK with status code" $HTTP_Status
}
Else {
  echo "The Site may be down, please check!"
}

echo "Your website is:"
echo $url

exit 0
