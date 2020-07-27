<?php

include '../../open.php';

//Collect the POST data and set them as variables
$email = $link->real_escape_string($_POST["mob_register_email"]);
$password = md5($link->real_escape_string($_POST["mob_register_password"]));

if (isset($_POST["mob_register_gender"])) {
	if ($_POST["mob_register_gender"] == 'M') {
		$gender = 'M';
	} elseif ($_POST["mob_register_gender"] == 'F') {
		$gender = 'F';
	}
} else {
	$gender = 'X';
}

if (isset($_POST["mob_register_birthday"])) {
	$birthday = date('Y-m-d H:i:s', strtotime(str_replace('-', '/', $link->real_escape_string($_POST["mob_register_birthday"]))));
} else {
	$birthday = date('Y-m-d H:i:s', strtotime('01/01/1970'));
}

if (isset($_POST["mob_register_location"])) {	
	$location = $link->real_escape_string($_POST["mob_register_location"]);
} else {
	$location = 40032;
}

if (isset($_POST["mob_register_updates"])) {
	$updates = 'Y';
} else {
	$updates = 'N';	
}

$exists = 0;
$name = 'n';

//Check user isn't already in the database
$sql = "SELECT 1 FROM A_USER WHERE USER_EMAIL = '$email'";
$res = $link->query($sql);

while ($row = $res->fetch_array()) {
	$exists = $row['1'];
}

if ($exists == 1) {
	$arr = array("mob_register_success" => "mob already exists");
	echo json_encode($arr);
} else {
	//Insert user into the database
	$sql = "INSERT INTO A_USER VALUES (NULL, '$email', '$password', '$gender', '$birthday', $location, '$updates', SYSDATE(), NULL, NULL, 0)";
	$link->query($sql);

	//Check user was loaded into the database and grab a name from their email
	$sql = "SELECT SUBSTRING(USER_EMAIL, 1, LOCATE('@', USER_EMAIL) - 1) AS NAME, USER_ID FROM A_USER WHERE USER_EMAIL = '$email' AND USER_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$name = $row['NAME'];
		$userid= $row['USER_ID'];
	} 

	if ($name != 'n') {
		$sql = "INSERT INTO C_LOGIN VALUES (NULL, $userid, NULL, SYSDATE())";
		$link->query($sql);

		$arr = array("mob_register_success" => "mob register success", "mob_register_email" => $email, "mob_register_password" => $password, "mob_register_name" => $name);
		echo json_encode($arr);
	} else {
		$arr = array("mob_register_success" => "mob register failed");
		echo json_encode($arr);
	}
}

include '../../close.php';

?>
