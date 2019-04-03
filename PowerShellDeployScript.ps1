      #Build url to test
	       $port = "8080"
	       $url = ""
	       $recipients = "prateek.chawla@elephant.com"
	       echo "URL to test : http://myfirstazurewebsiteadmiral.azurewebsites.net" 
	
	       $i = 0
	       $Content_Test = "g"
	       
	       $Response = Invoke-WebRequest http://google.com -UseBasicParsing
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
	              Start-Sleep -s 2
	              $Response = Invoke-WebRequest http://google.com -UseBasicParsing
	              $Content = $Response.Content
	              $i++
	       }
	
	       #page has returned the correct content
	       echo "Good HTTP Content"
         
send-mailmessage -from "AutomationReportAgent@inspopindia.com" -to "prateek.chawla@elephant.com" -BodyAsHtml -subject "Successful Deployment of" -body "<This is an automated message sent from Jenkins>" -smtpServer EXCHANGE.InspopCorp.com
 
echo http://$WEBAPP_NAME.azurewebsites.net
   
