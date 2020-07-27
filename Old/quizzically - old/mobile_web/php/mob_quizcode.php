<?php

include '../../open.php';

$email = $link->real_escape_string($_POST["mob_quiz_email"]);
$password = $link->real_escape_string($_POST["mob_quiz_password"]);
$quizcode = $link->real_escape_string($_POST["mob_quiz_quizcode"]);

$success1 = 0;
$success2 = 0;

$sql = "SELECT 1 FROM B_QUIZ a, B_GAME b WHERE a.QUIZ_ID = b.QUIZ_ID AND a.QUIZ_CODE = '$quizcode' AND b.QUIZ_STATUS <> 'F'";
$res = $link->query($sql);

while ($row = $res->fetch_array()) {
    $success1 = $row['1'];
} 

if ($success1 != 0) {
	$sql = "SELECT 1 FROM B_PARTICIPANT WHERE USER_ID = (SELECT USER_ID FROM A_USER WHERE USER_PASSWORD = '$password' AND USER_EMAIL = '$email') AND QUIZ_ID = (SELECT QUIZ_ID FROM B_QUIZ WHERE QUIZ_CODE = '$quizcode')";
	$res = $link->query($sql);
	
	while ($row = $res->fetch_array()) {
		$success2 = $row['1'];
	}
	
	if ($success2 == 0) {
		$sql = "INSERT INTO B_PARTICIPANT 
					SELECT NULL, a.USER_ID, b.QUIZ_ID, SYSDATE(), 0 
						FROM A_USER a, B_QUIZ b
						WHERE a.USER_EMAIL = '$email'
						AND a.USER_PASSWORD = '$password'
						AND b.QUIZ_CODE = '$quizcode'";
		$res = $link->query($sql);	
	}
	$arr = array("mob_quiz_success" => "mob quiz success", "mob_quiz_code" => $quizcode);
	echo json_encode($arr);
} else {
    $arr = array("mob_quiz_success" => "mob quiz failed");
	echo json_encode($arr);  
}

include '../../close.php';

?>