$RepoPath = "https://github.com/prateekchawla/SecondGit"

$appID="717152e6-feef-4c22-904e-bad03901940d"
$password="/DJv.^g!_#Q|)II_[};-1$W/#-$>?r$dI/*&}*6"
$tenant="a26a5ff8-8542-4fff-b6de-bee30a6b56b7"
$RESOURCE_NAME="AzureResourceGroup"
$PLAN_NAME="AzurePlan"
$WEBAPP_NAME="MyFirstAzureWebsiteAdmiral"
$EmailUsername = "prateek.chawla";
$EmailPassword = "Galaxyyoung123";
$FromEmail = "AutomationReportAgent@inspopindia.com";
$SMPTP_Server = "EXCHANGE.InspopCorp.com";


function Send-ToEmail([string]$email , [string]$Subject , [string]$Body){

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
	       
	       $Response = Invoke-WebRequest $url -UseBasicParsing
	       $Content = $Response.Content
	
	       while(!($Content -match $Content_Test))
	       {
	              if($i -eq 2){
	                     #it has been more than 2 minutes and the page never returned good content
	                     #send out an alert email
	                     echo "It has been 2 minutes without a good response..."
	                     echo "Aborting the job and sending an alert email"
	                     Send-ToEmail  -email "prateek.chawla@inspopindia.com" -Subject "UnSuccessful Deployment of $WEBAPP_NAME" -Body "This is an Automated mail by Jenkins"
	                     exit 1
	              }
	              #page is still not returning the correct content
	              echo "Bad HTTP Content Response"
	              echo "Sleeping 1 minute..."
	              Start-Sleep -s 60
	              $Response = Invoke-WebRequest $url -UseBasicParsing
	              $Content = $Response.Content
	              $i++
	       }
	#page has returned the correct content
	echo "Good HTTP Content"
        Send-ToEmail  -email "prateek.chawla@inspopindia.com" -Subject "Successful Deployment of $WEBAPP_NAME" -Body "This is an Automated mail by Jenkins"
 
echo $url

choco install curl -yes
curl -v http://myfirstazurewebsiteadmiral.azurewebsites.net
$status = curl -Is "http://myfirstazurewebsiteadmiral.azurewebsites.net" | head -n 1
echo $status
