<?php
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';

//Collect the posted data and set them as variables
$email = $link->real_escape_string($_POST["register_email"]);
$password = md5($link->real_escape_string($_POST["register_password"]));

if (isset($_POST["register_organisation"])) {	
	$organisation = $link->real_escape_string($_POST["register_organisation"]);
} else {
	$organisation = 'No Organisation';
}

if (isset($_POST["register_location"])) {	
	$location = $link->real_escape_string($_POST["register_location"]);
} else {
	$location = '40032';
}

if (isset($_POST["register_updates"])) {
	$updates = 'Y';
} else {
	$updates = 'N';	
}

$exists = 0;
$name = 'n';

//Check client is not already in the database
$sql = "SELECT 1 FROM A_CLIENT WHERE CLIENT_EMAIL = '$email'";
$res = $link->query($sql);

while ($row = $res->fetch_array()) {
	$exists = $row['1'];
}

if ($exists == 1) {
	$arr = array("register_success" => "already exists");
	echo json_encode($arr);
} else {
	//Insert client into the database
	$sql = "INSERT INTO A_CLIENT VALUES (NULL, '$email', '$password', '$organisation', '$location', '$updates', SYSDATE(), 0, 0, NULL, NULL)";
	$res = $link->query($sql);

	//Check client was loaded into the database and grab a name from their email
	$sql = "SELECT SUBSTRING(CLIENT_EMAIL, 1, LOCATE('@', CLIENT_EMAIL) - 1) AS NAME, CLIENT_ID, QUIZ_CREDIT FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$name = $row['NAME'];
		$clientid = $row['CLIENT_ID'];
		$quizcredit = $row['QUIZ_CREDIT'];
	} 

	if ($name != 'n') {
		$sql = "INSERT INTO C_LOGIN VALUES (NULL, NULL, $clientid, SYSDATE())";
		$res = $link->query($sql);

		$arr = array("register_success" => "register success", "register_email" => $email, "register_password" => $password, "register_name" => $name, "register_credit" => $quizcredit);
		echo json_encode($arr);
	} else {
		$arr = array("register_success" => "register failed");
		echo json_encode($arr);
	}
}

include '../../close.php';

?>
