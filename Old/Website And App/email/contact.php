<?PHP

require_once('../php/recaptchalib.php');
$privatekey = "6LfCRfoSAAAAAOaiprZNVIIamknz7KbZbPHyB1mv";
$resp = recaptcha_check_answer ($privatekey, $_SERVER["REMOTE_ADDR"], $_POST["recaptcha_challenge_field"], $_POST["recaptcha_response_field"]);

if (!$resp->is_valid) {
	
	$redirect_url = "http://www.quizzically.co.uk/index.php?valid=no"; //Redirect URL after submit the form
	header("Location: $redirect_url");

} else {
	   
	ob_start();

	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	
		require("class.phpmailer.php");

		$mail = new PHPMailer();

		//Your SMTP servers details

		$mail->IsSMTP();               // set mailer to use SMTP
		$mail->Host = "smtp.mandrillapp.com";  // specify main and backup server or localhost
		$mail->Port = 587;   //Specify port
		$mail->SMTPAuth = true;     // turn on SMTP authentication
		$mail->Username = "matthew.davis.1978@gmail.com";  // SMTP username
		$mail->Password = "Rl8UDVIuJKpYrRyn_pVrjQ"; // SMTP password
		//It should be same as that of the SMTP user
		
		$redirect_url = "http://www.quizzically.co.uk/index.php?valid=yes"; //Redirect URL after submit the form

		$mail->From = "quizzically@quizzically.co.uk";	//Default From email same as smtp user
		$mail->FromName = "www.quizzically.co.uk";

		$mail->AddAddress("matthew.davis.1978@gmail.com", "Matthew"); //Email address where you wish to receive/collect those emails.

		$mail->WordWrap = 50;                                 // set word wrap to 50 characters
		$mail->IsHTML(true);                                  // set email format to HTML

		$mail->Subject = $_POST['subject'];
		$message = "Name of the requestor :".$_POST['name']." \r\n <br>Email Adrress :".$_POST['email']." \r\n <br> Query :".$_POST['message'];
		$mail->Body    = $message;

		if(!$mail->Send()) {
			echo "Message could not be sent. <p>";
			echo "Mailer Error: " . $mail->ErrorInfo;
			exit;
		}

		header("Location: $redirect_url");
	}

}

?>