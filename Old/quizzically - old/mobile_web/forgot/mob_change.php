<html>
<!--
	Matthew Davis
	01/05/2014
-->

	<head>
		<meta charset="utf-8">
		<link rel="shortcut icon" href="http://www.quizzically.co.uk/quizzically/mobile_web/forgot/favicon.ico" type="image/icon"> 
		<link rel="icon" href="http://www.quizzically.co.uk/quizzically/mobile_web/forgot/favicon.ico" type="image/icon">
		<title>quizzically</title>
	
		<link rel="stylesheet" href="http://www.quizzically.co.uk/quizzically/mobile_web/forgot/css/mob_login.css">
		<script type="text/javascript" charset="utf-8" src="http://www.quizzically.co.uk/quizzically/mobile_web/forgot/js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" charset="utf-8" src="http://www.quizzically.co.uk/quizzically/mobile_web/forgot/js/mob_change.js"></script>
		
		<script>
			if ( $.browser.msie ) {
				$("#textarea-id").val('placeholder');
				$("#textarea-id").focus(function(){
					this.select();
				});
			}
		</script>
	<head>
	
	<body id="web_change">
		<div id="web_top_background"></div>
		<div id="web_content_wrapper">
			<div id="web_logo_top">
				<img src="http://www.quizzically.co.uk/quizzically/mobile_web/forgot/img/quizzically_logo.png" width="100%" alt="quizzically logo" id="quizzically_logo" style="background-image:url('http://www.quizzically.co.uk/quizzically/mobile_web/forgot/img/background.png'); background-repeat:repeat;">			
			</div>
			<br><br>
			<div id="mob_change_content">
				<?php
					include 'http://www.quizzically.co.uk/quizzically/open.php';
					//Take in variables
					$forgot_key = $link->real_escape_string($_GET["forgot_key"]);
					$sql = "SELECT SUBSTRING(USER_EMAIL, 1, LOCATE('@', USER_EMAIL) - 1) AS NAME, USER_EMAIL, EXPIRE FROM A_USER WHERE RESET = '$forgot_key'";
					$res = $link->query($sql);
					while ($row = $res->fetch_array()) {
						$email = $row['USER_EMAIL'];
						$name = $row['NAME'];
						$expire = $row['EXPIRE'];
					}
					if ((time() - $expire) > 86400) {
						$sql = "UPDATE A_USER SET RESET = NULL, EXPIRE = NULL WHERE RESET = '$forgot_key'";
						$res = $link->query($sql);
						echo "<div class='error'>
								<h2>Sorry!</h2>
								Password reset link expired. Please try again!
							</div>";
					} else {
						echo "<form id='mob_change_form'>
								Please enter a new password for your account
								<input style='width: 80%;' class='text_input' name='mob_change_email' id='mob_change_email' value='" . $email ."' type='email' disabled>
								<br><br>
								<input style='width: 80%;' class='text_input' name='mob_change_password' id='mob_change_password' placeholder='Password' value='' type='password'>
								<br><br>
								<input style='width: 80%;' class='text_input' name='mob_change_repeat_password' id='mob_change_repeat_password' placeholder='Repeat Password' value='' type='password'>
								<br><br>
								<input type='hidden' name='forgot_key' id='forgot_key' value='" . $forgot_key . "'>
								<input class='button' name='submit' type='submit' value='Change Password'/>
							</form>";	
					}
					include 'http://www.quizzically.co.uk/quizzically/close.php';
				?>
			</div>
			<br>
		</div>		
    </body>
	
</html>
