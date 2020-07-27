<?php
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';

//Collect the posted data and set them as variables
$email = $link->real_escape_string($_POST["profile_email"]);

$password = $link->real_escape_string($_POST["profile_old_password"]);
if (isset($_POST["profile_password"]) && !is_null($_POST["profile_password"]) && $_POST["profile_password"] != "") {
	$password = $link->real_escape_string($_POST["profile_password"]);
	$password = md5($password);
}

if (isset($_POST["profile_old_email"])) {
	$oldemail = $link->real_escape_string($_POST["profile_old_email"]);
}

if (isset($_POST["profile_old_password"])) {
	$oldpassword = $link->real_escape_string($_POST["profile_old_password"]);
}

$organisation = 'NoOrganisation';
if (isset($_POST["profile_organisation"])) {
	$organisation = $link->real_escape_string($_POST["profile_organisation"]);
}

$location = 40032;
if (isset($_POST["profile_location"])) {
	$location = $link->real_escape_string($_POST["profile_location"]);
}

$updates = 'N';
if (isset($_POST["profile_updates"])) {
	$updates = 'Y';
}

$type = $link->real_escape_string($_POST["profile_type"]);
$name = 'n';

if ($type == "fill") {

	//Retrieve client details
	$sql = "SELECT ORGANISATION, LOCATION_ID, CLIENT_UPDATES FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$organisation = $row['ORGANISATION'];
		$location = $row['LOCATION_ID'];
		$updates = $row['CLIENT_UPDATES'];
	}

	if ($updates == "Y") {
		$updates = true;
	} else {
		$updates = false;
	}

	if ($organisation != "NoOrganisation") {
		$arr = array("profile_success" => "profile fill success", "profile_email" => $email, "profile_organisation" => $organisation, "profile_location" => $location, "profile_updates" => $updates);
		echo json_encode($arr);
	} else {
		$arr = array("profile_success" => "profile fill fail");
		echo json_encode($arr);
	}

} else if ($type == "update") {

	//Update client in the database
	$sql = "UPDATE A_CLIENT SET CLIENT_EMAIL = '$email', CLIENT_PASSWORD = '$password', ORGANISATION = '$organisation', LOCATION_ID = $location, CLIENT_UPDATES = '$updates' WHERE CLIENT_EMAIL = '$oldemail' AND CLIENT_PASSWORD = '$oldpassword'";
	$res = $link->query($sql);

	//Check client was updated and grab a name from their email
	$sql = "SELECT CASE WHEN LENGTH(ORGANISATION) = 0 THEN  SUBSTRING(CLIENT_EMAIL, 1, LOCATE('@', CLIENT_EMAIL) - 1) ELSE ORGANISATION END AS NAME FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$name = $row['NAME'];
	}

	if ($name != 'n') {
		$arr = array("profile_success" => "profile update success", "profile_email" => $email, "profile_password" => $password, "profile_name" => $name);
		echo json_encode($arr);
	} else {
		$arr = array("profile_success" => "profile update failed");
		echo json_encode($arr);
	}
}

include '../../close.php';

?>
