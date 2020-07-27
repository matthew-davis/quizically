<?php
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';

//Collect the posted data and set them as variables
$email = $link->real_escape_string($_POST["purchase_email"]);
$password = $link->real_escape_string($_POST["purchase_password"]);
$purchaseqty = $link->real_escape_string($_POST["purchase_qty"]);


if ($purchaseqty == "one") {

	$sql = "UPDATE A_CLIENT SET QUIZ_CREDIT = (QUIZ_CREDIT + 1) WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	$sql = "SELECT QUIZ_CREDIT FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$quizcredit = $row['QUIZ_CREDIT'];
	}

	$arr = array("purchase_success" => "purchase success", "quiz_credit" => $quizcredit);
	echo json_encode($arr);

} else if ($purchaseqty == "five") {

	$sql = "UPDATE A_CLIENT SET QUIZ_CREDIT = QUIZ_CREDIT + 5 WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	$sql = "SELECT QUIZ_CREDIT FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$quizcredit = $row['QUIZ_CREDIT'];
	}

	$arr = array("purchase_success" => "purchase success", "quiz_credit" => $quizcredit);
	echo json_encode($arr);

} else if ($purchaseqty == "ten") {

	$sql = "UPDATE A_CLIENT SET QUIZ_CREDIT = QUIZ_CREDIT + 10 WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	$sql = "SELECT QUIZ_CREDIT FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$quizcredit = $row['QUIZ_CREDIT'];
	}

	$arr = array("purchase_success" => "purchase success", "quiz_credit" => $quizcredit);
	echo json_encode($arr);

}

include '../../close.php';

?>
