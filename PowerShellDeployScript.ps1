
 $recipients = "prateek.chawla@inspopindia.com"
   
          send-mailmessage -from "AutomationReportAgent@inspopindia.com"  -to $recipients -BodyAsHtml -subject "Successful GuideWire 9 BillingCenter $ENVIRONMENT Deployment" -body "<font face = Calibri>The newest code version has been deployed to the GW9 <b>BillingCenter</b> application in <b>$ENVIRONMENT</b>.<br>The server is now back up and returns the correct page content.<br><br>The log of the code changes included in this deployment is below:<br><font color=#21618C>$GitFileContent</font><br><br><font color=#626567>This is an automated message sent from Jenkins.</font></font>" -smtpServer EXCHANGE.InspopCorp.com
