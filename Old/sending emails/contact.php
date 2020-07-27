<?
ob_start();
if(isset($_POST['btnSubmit']))
{
require("class.phpmailer.php");

$mail = new PHPMailer();

//Your SMTP servers details

$mail->IsSMTP();               // set mailer to use SMTP
$mail->Host = "yourmailserver.com or localhost;  // specify main and backup server or localhost
$mail->SMTPAuth = true;     // turn on SMTP authentication
$mail->Username = "example@yourdomain.com";  // SMTP username
$mail->Password = "password"; // SMTP password
//It should be same as that of the SMTP user

$redirect_url = "http://".$_SERVER['SERVER_NAME']; //Redirect URL after submit the form

$mail->From = $mail->Username;	//Default From email same as smtp user
$mail->FromName = "Display Name";

$mail->AddAddress("info@yourdomain.com", "your name"); //Email address where you wish to receive/collect those emails.

$mail->WordWrap = 50;                                 // set word wrap to 50 characters
$mail->IsHTML(true);                                  // set email format to HTML

$mail->Subject = $_POST['subject'];
$message = "Name of the requestor :".$_POST['fullname']." \r\n <br>Email Adrress :".$_POST['email']." \r\n <br> Query :".$_POST['query'];
$mail->Body    = $message;

if(!$mail->Send())
{
   echo "Message could not be sent. <p>";
   echo "Mailer Error: " . $mail->ErrorInfo;
   exit;
}

echo "Message has been sent";
header("Location: $redirect_url");
}
?>
