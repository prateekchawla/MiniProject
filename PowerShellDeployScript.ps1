$Username = "prateek.chawla";
$Password = "Galaxyyoung123";


function Send-ToEmail([string]$email){

    $message = new-object Net.Mail.MailMessage;
    $message.From = "AutomationReportAgent@inspopindia.com";
    $message.To.Add($email);
    $message.Subject = "Jenkinsssssssssssssss...";
    $message.Body = "mail by jenkins...";
    

    $smtp = new-object Net.Mail.SmtpClient("EXCHANGE.InspopCorp.com");
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message);
    write-host "Mail Sent" ; 
 }
Send-ToEmail  -email "prateek.chawla@inspopindia.com" 
