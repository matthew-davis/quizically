<?php
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';
require 'generatecode.php';

//Capture posted variables
$email = $link->real_escape_string($_POST["quiz_email"]);
$password = $link->real_escape_string($_POST["quiz_password"]);
$questions = $link->real_escape_string($_POST["quiz_questions"]);

$difficulty = $link->real_escape_string($_POST["quiz_difficulty"]);
$sql = "SELECT DIFFICULTY_ID FROM D_DIFFICULTY WHERE DIFFICULTY = $difficulty";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
	$difficulty = $row['DIFFICULTY_ID'];
}

$location = 40032;
if (isset($_POST["quiz_location"])) {	
	$location = $link->real_escape_string($_POST["quiz_location"]);
}

$credit = 0;
$sql = "SELECT 1 AS CREDIT FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password' AND QUIZ_CREDIT > 0";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
	$credit = $row['CREDIT'];
}

$quizid = 0;

if ($credit != 0) {
	//Generate a unique quiz code 
	//Currently this is a randomly selected word out of a list of almost 6000 five letter words, needs upgraded
	$getCode = new getCode();
	$quizcode = $getCode->generateCode();

	//Create quiz
	$sql = "SELECT CLIENT_ID FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$clientid = $row['CLIENT_ID'];
	}
		
	$sql = "INSERT INTO B_QUIZ (QUIZ_ID, QUIZ_CODE, NO_OF_QUESTIONS, DIFFICULTY_ID, LOCATION_ID, QUIZ_REGISTERED, QUIZ_COMPLETED, NO_OF_USERS, CLIENT_ID) VALUES (NULL, '$quizcode', $questions, $difficulty, $location, SYSDATE(), NULL, 0, $clientid)";
	$res = $link->query($sql);

	//Check for quiz
	$sql = "SELECT QUIZ_ID FROM B_QUIZ WHERE QUIZ_CODE = '$quizcode'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$quizid = $row['QUIZ_ID'];
	}
	
	//Remove a Credit
	$sql = "UPDATE A_CLIENT SET QUIZ_CREDIT = QUIZ_CREDIT - 1 WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);
	
	$sql = "SELECT QUIZ_CREDIT FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$quizcredit = $row['QUIZ_CREDIT'];
	}

	if ($quizid != 0) {
		
		//Create first B_GAME entry
		$sql = "INSERT INTO B_GAME (GAME_ID, QUIZ_ID, QUESTIONS_LEFT, DIFFICULTY_ID, QUESTION_ID, QUIZ_STATUS) VALUES (NULL, $quizid, $questions, $difficulty, NULL, 'N')";
		$res = $link->query($sql);

		$arr = array("quiz_success" => "quiz success", "quiz_code" => $quizcode, "quiz_credit" => $quizcredit);
		echo json_encode($arr);
	} else {
		$arr = array("quiz_success" => "quiz failed");
		echo json_encode($arr);
	}
} else {
	$arr = array("quiz_success" => "no credit");
	echo json_encode($arr);
}

include '../../close.php';

?>