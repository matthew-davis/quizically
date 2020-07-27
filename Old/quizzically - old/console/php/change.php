<!DOCTYPE html>
<!--
	Matthew Davis
	Wittin Limited
	01/09/2014
-->

<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="quizzically is the first game developed by Wittin. It's about bringing the fun back to the pub quiz. It removes the element of mobile cheating, cuts out lengthy marking delays and facilitates easier quiz creation. What could be better?">
		<meta name="author" content="Wittin Ltd.">
		<link rel="shortcut icon" href="favicon.ico" type="image/icon"> 
		<link rel="icon" href="favicon.ico" type="image/icon">
		<title>quizzically</title>

		<link href="../css/bootstrap.min.css" rel="stylesheet">
		<link href="../css/console.css" rel="stylesheet">

		<script src="../js/jquery-2.0.3.min.js"></script>
		<script src="../js/aesthetics/bootstrap.min.js"></script>
		<script src="../js/functionality/change.js"></script>
		
		<!--[if lt IE 9]>
			<script src="../js/aesthetics/html5shiv.min.js"></script>
			<script src="../js/aesthetics/respond.min.js"></script>
		<![endif]-->	
		
	</head>
	
	<body>
	
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<div class="login-panel panel panel-default">
						<div class="panel-heading">
							<img src="../img/login_logo.png" width="100%" alt="quizzically logo">
						</div>
						<div class="panel-body">
							<br>
							<?php
								include '../../open.php';
									
								$forgot_key = $link->real_escape_string($_GET["forgot_key"]);
									
								$sql = "SELECT SUBSTRING(CLIENT_EMAIL, 1, LOCATE('@', CLIENT_EMAIL) - 1) AS NAME, CLIENT_EMAIL, EXPIRE FROM A_CLIENT WHERE RESET = '$forgot_key'";
								$res = $link->query($sql);
									
								while ($row = $res->fetch_array()) {
									$email = $row['CLIENT_EMAIL'];
									$name = $row['NAME'];
									$expire = $row['EXPIRE'];
								}
									
								if ((time() - $expire) > 86400) {
									$sql = "UPDATE A_CLIENT SET RESET = NULL, EXPIRE = NULL WHERE RESET = '$forgot_key'";
									$res = $link->query($sql);
									echo "<div class='error'><h2>Sorry!</h2>Password reset link expired. Please try again!</div>";
									
								} else {
									echo "<form role='form' id='change_form' name='change_form'>
										      <fieldset disabled>
											      <div class='form-group'>
												      <input class='form-control' id='disabledInput' name='change_email' type='email' value='" . $email . "' disabled'>
												  </div>
											  </fieldset>
											  <fieldset>
												  <div class='form-group'>
													  <input class='form-control' placeholder='Password' name='change_password' type='password' value=''>
												  </div>
												  <div class='form-group'>
													  <input class='form-control' placeholder='Repeat Password' name='change_repeat_password' type='password' value=''>
												  </div>
												  <br>
												  <input type='hidden' name='forgot_key' id='forgot_key' value='" . $forgot_key . "'>
												  <input class='btn btn-lg btn-primary btn-block' type='submit' value='Change Password' />
										      </fieldset>
										  </form>";	
								}
								
								include '../../close.php';
							?>
						</div>
						<div class="panel-footer">
							<p>After entering a new password and clicking on "Change Password" you can sign on again with your new password.</p>
						</div>
					</div>
				</div>
			</div>
		</div>		
		
	</body>

</html>	
	
	
	
	
	

			
			
