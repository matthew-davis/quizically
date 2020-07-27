<?PHP

include '../open.php';

//Collect the posted data and set them as variables
$email = $link->real_escape_string($_POST["mob_profile_old_email"]);
$oldemail = $link->real_escape_string($_POST["mob_profile_old_email"]);
$oldpassword = $link->real_escape_string($_POST["mob_profile_old_password"]);
$password = $link->real_escape_string($_POST["mob_profile_old_password"]);
if (isset($_POST["mob_profile_password"]) && !is_null($_POST["mob_profile_password"]) && $_POST["mob_profile_password"] != "") {
	$password = md5($link->real_escape_string($_POST["mob_profile_password"]));
}

$gender = 'X';
if (isset($_POST["mob_profile_gender"])) {
	if ($_POST["mob_profile_gender"] == 'M') {
		$gender = 'M';
	} elseif ($_POST["mob_profile_gender"] == 'F') {
		$gender = 'F';
	}
}

if (isset($_POST["mob_profile_birthday"])) {
	$birthday = date('Y-m-d H:i:s', strtotime(str_replace('-', '/', $link->real_escape_string($_POST["mob_profile_birthday"]))));
} else {
	$birthday = date('Y-m-d H:i:s', strtotime('01/01/1970'));
}

$location = 40032;
if (isset($_POST["mob_profile_location"])) {	
	$location = $link->real_escape_string($_POST["mob_profile_location"]);
}

if (isset($_POST["mob_profile_updates"])) {
	$updates = 'Y';
} else {
	$updates = 'N';	
}

$type = $link->real_escape_string($_POST["mob_profile_type"]);
$userid = 0;
$name = 'n';

//get details to be written to the profile page
if ($type == "details") {

	$sql = "SELECT USER_ID, GENDER, DATE_FORMAT(BIRTHDAY, '%Y-%m-%d') AS BIRTHDAY, CAST( LOCATION_ID AS CHAR( 10 ) ) AS LOCATION_ID, USER_UPDATES FROM A_USER WHERE USER_EMAIL = '$oldemail' and USER_PASSWORD = '$oldpassword'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$userid = $row['USER_ID'];
		$gender = $row['GENDER'];
		$birthday = $row['BIRTHDAY'];
		$location = $row['LOCATION_ID'];
		$updates = $row['USER_UPDATES'];
	}
	
	if ($updates == 'Y') {
		$updates = true;
	} else {
		$updates = false;
	}
	
	$genderm = false;
	$genderf = false;
	if ($gender == 'M') {
		$genderm = true;
	} else if ($gender == 'F') {
		$genderf = true;
	}
	
	if ($userid != 0) {
		$arr = array("mob_profile_success" => "mob details success", "mob_profile_email" => $email, "mob_profile_genderm" => $genderm, "mob_profile_genderf" => $genderf, "mob_profile_birthday" => $birthday, "mob_profile_location" => $location, "mob_profile_updates" => $updates);
		echo json_encode($arr);
	} else {
		$arr = array("mob_profile_success" => "mob profile user fail");
		echo json_encode($arr);
	}
	
} else if ($type == "update") {
	//Update client in the database
	$sql = "UPDATE A_USER SET USER_EMAIL = '$email', USER_PASSWORD = '$password', GENDER = '$gender', BIRTHDAY = '$birthday', LOCATION_ID = $location, USER_UPDATES = '$updates' WHERE USER_EMAIL = '$oldemail' AND USER_PASSWORD = '$oldpassword'";
	$res = $link->query($sql);

	//Check client was updated and grab a name from their email
	$sql = "SELECT SUBSTRING(USER_EMAIL, 1, LOCATE('@', USER_EMAIL) - 1) AS NAME, USER_ID FROM A_USER WHERE USER_EMAIL = '$email' AND USER_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$name = $row['NAME'];
		$userid = $row['USER_ID'];
	} 

	if ($name != 'n') {
		$arr = array("mob_profile_success" => "mob update success", "mob_profile_email" => $email, "mob_profile_password" => $password, "mob_profile_name" => $name);
		echo json_encode($arr);
	} else {
		$arr = array("mob_profile_success" => "mob profile failed");
		echo json_encode($arr);
	}
}

include '../close.php';

?>