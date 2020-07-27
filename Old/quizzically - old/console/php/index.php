<?php
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';

//Take in variables
$email = $link->real_escape_string($_POST["login_email"]);
$password = $link->real_escape_string($_POST["login_password"]);
$auto = $link->real_escape_string($_POST["login_auto"]);
$name = 'n';

if ($auto == 'n') {
    $password = md5($password);
}

$success = 0;

//Check if user exists
$sql = "SELECT 1 FROM A_CLIENT WHERE CLIENT_EMAIL = '$email'";
$res = $link->query($sql);

while ($row = $res->fetch_array()) {
    $success = $row['1'];
} 

if ($success != 1) {
	$arr = array("login_success" => "no account");
	echo json_encode($arr);
} else {

	//Check if password is correct
	$sql = "SELECT CASE WHEN LENGTH(ORGANISATION) = 0 THEN  SUBSTRING(CLIENT_EMAIL, 1, LOCATE('@', CLIENT_EMAIL) - 1) ELSE ORGANISATION END AS NAME, CLIENT_ID, QUIZ_CREDIT FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$name = $row['NAME'];
		$clientid = $row['CLIENT_ID'];
		$quizcredit = $row['QUIZ_CREDIT'];
	} 

	if ($name != 'n') {
		$sql = "INSERT INTO C_LOGIN VALUES (NULL, NULL, $clientid, SYSDATE())";
		$res = $link->query($sql);
	
		$arr = array("login_success" => "login success", "login_email" => $email, "login_password" => $password, "login_name" => $name, "login_credit" => $quizcredit);
		echo json_encode($arr);
	} else {
		$arr = array("login_success" => "password failed");
		echo json_encode($arr);
	}

}

include '../../close.php';

?>