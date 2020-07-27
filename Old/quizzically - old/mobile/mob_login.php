<?php

include '../open.php';

//Take in variables
$email = $link->real_escape_string($_POST["mob_login_email"]);
$password = $link->real_escape_string($_POST["mob_login_password"]);
$auto = $link->real_escape_string($_POST["mob_login_auto"]);
$name = 'n';

if ($auto == 'n') {
    $password = md5($password);
}

//Check if user exists
$sql = "SELECT 1 FROM A_USER WHERE USER_EMAIL = '$email'";
$res = $link->query($sql);

while ($row = $res->fetch_array()) {
    $success = $row['1'];
} 

if ($success != 1) {
	$arr = array("mob_login_success" => "mob no account");
	echo json_encode($arr);
} else {

	//Check if password is correct
	$sql = "SELECT SUBSTRING(USER_EMAIL, 1, LOCATE('@', USER_EMAIL) - 1) AS NAME, USER_ID FROM A_USER WHERE USER_EMAIL = '$email' AND USER_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$name = $row['NAME'];
		$userid = $row['USER_ID'];
	} 

	if ($name != 'n') {
		$sql = "INSERT INTO C_LOGIN VALUES (NULL, $userid, NULL, SYSDATE())";
		$res = $link->query($sql);
		
		$arr = array("mob_login_success" => "mob login success", "mob_login_email" => $email, "mob_login_password" => $password, "mob_login_name" => $name);
		echo json_encode($arr);
	} else {
		$arr = array("mob_login_success" => "mob password failed");
		echo json_encode($arr);
	}
}

include '../close.php';

?>