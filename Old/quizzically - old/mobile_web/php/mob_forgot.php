<?php
//
//	Matthew Davis
//	01/05/2014
//

include 'http://www.quizzically.co.uk/quizzically/open.php';

$email = $link->real_escape_string($_POST["mob_forgot_email"]);
$sendemail = 0; 

$sql = "SELECT SUBSTRING(USER_EMAIL, 1, LOCATE('@', USER_EMAIL) - 1) AS NAME, USER_EMAIL FROM A_USER WHERE USER_EMAIL = '$email' LIMIT 1";
$res = $link->query($sql);

if ($res->num_rows == 0) {
	$arr = array("mob_forgot_success" => "mob no account");
	echo json_encode($arr);
} 

while ($row = $res->fetch_array()) {
	$sendemail = $row['USER_EMAIL'];
	$name = $row['NAME'];
}

require("http://www.quizzically.co.uk/quizzically/mobile_web/forgot/email/class.phpmailer.php");

$mail = new PHPMailer();

$mail->IsSMTP(); 									// telling the class to use SMTP
$mail->Host = "smtp.mandrillapp.com"; 				// SMTP server
$mail->Port = 587;									// SMTP Port
$mail->SMTPAuth = true;                  			// enable SMTP authentication
$mail->Username = "matthew.davis.1978@gmail.com"; 	// SMTP account username
$mail->Password = "Rl8UDVIuJKpYrRyn_pVrjQ";        	// SMTP account password

$mail->From = "quizzically@quizzically.co.uk";
$mail->FromName = "quizzically";
$mail->AddAddress($sendemail);
$mail->WordWrap = 50;
$mail->IsHTML(true);
$mail->Subject = "quizzically password reset confirmation";
	
$salt = sha1(uniqid()); 					//generate salt
$now = time(); 								//get current time
$forgot_key = sha1($name . $now . $salt);	//forgot key
	
$sql = "UPDATE A_USER SET EXPIRE = '$now', RESET = '$forgot_key' WHERE USER_EMAIL = '$email'";
$res = $link->query($sql);

$mailer = "<div style='margin: 0 auto; width: 520px; padding: 12px; float: left;'>
			   <div>
		           <img src='http://www.quizzically.co.uk/quizzically/mobile_web/forgot/img/quizzically_logo.png' width='300px' alt='quizzically logo' style='background-image:url(\"http://www.quizzically.co.uk/quizzically/mobile_web/forgot/img/background.png\"); background-repeat:repeat; float: left;' />
				   <br><br>
			   </div>
			   <br><br><br>
		       Hi " . $name . ",
		       <br><br> 
		       There was recently a request to change the password on your account. If you requested this password change, please set a new password by following the link below:
		       <br><br>
		       <a href='http://www.quizzically.co.uk/quizzically/mobile_web/forgot/mob_change.php?forgot_key=" . $forgot_key . "'>http://www.quizzically.co.uk/quizzically/mobile_web/forgot/mob_change.php?forgot_key=" . $forgot_key . "</a>
		       <br><br>
		       Please note that this link is only valid for 24 hours.
		       <br><br>
	           If you don't want to change your password, just ignore this message.
		       <br><br>
		       Thanks,
		       <br>
		       quizzically Team
	       </div>";
$mail->Body = $mailer;

if(!$mail->Send()) {
	$arr = array("mob_forgot_success" => "mob no send");
	echo json_encode($arr);
} else {
	$arr = array("mob_forgot_success" => "mob forgot success");
	echo json_encode($arr);
}

include 'http://www.quizzically.co.uk/quizzically/close.php';

?>