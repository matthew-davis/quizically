<?php
//
//Matthew Davis
//11/03/2014
//
include '../../open.php';

$quizcode = $link->real_escape_string($_POST["mob_quizcode"]);
$email = $link->real_escape_string($_POST["user_email"]);
$password = $link->real_escape_string($_POST["user_password"]);

$sql = "SELECT QUIZ_ID FROM B_QUIZ WHERE QUIZ_CODE = '$quizcode'";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
    $quizid = $row['QUIZ_ID'];
}

$sql = "SELECT USER_ID FROM A_USER WHERE USER_EMAIL = '$email' AND USER_PASSWORD = '$password'";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
    $userid = $row['USER_ID'];
}

$sql = "SELECT PARTICIPANT_ID FROM B_PARTICIPANT WHERE USER_ID = $userid AND QUIZ_ID = $quizid";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
    $participantid = $row['PARTICIPANT_ID'];
}

$sql = "SELECT SUBSTRING(b.USER_EMAIL, 1, LOCATE('@', b.USER_EMAIL) - 1) AS NAME,
			   a.SCORE,
			   CASE WHEN IFNULL(CORRECT, -1) = 1 THEN 'Correct'
			   		WHEN IFNULL(CORRECT, -1) = -1 THEN 'Start'
			   		WHEN IFNULL(CORRECT, -1) = 0 THEN 'Incorrect'
					END AS CLASS
			   	   
			FROM B_PARTICIPANT a
					LEFT JOIN A_USER b ON a.USER_ID = b.USER_ID
					LEFT JOIN (SELECT CORRECT FROM C_INTERACTION WHERE INTERACTION_ID = (SELECT MAX(INTERACTION_ID) FROM C_INTERACTION WHERE PARTICIPANT_ID = $participantid)) c ON 0 = 0		
 
			WHERE a.QUIZ_ID IN (SELECT QUIZ_ID FROM B_QUIZ WHERE QUIZ_CODE = '$quizcode')
			AND a.PARTICIPANT_ID = $participantid";
$res = $link->query($sql);

$rows = array();

while ($r = $res->fetch_assoc()) {
	$rows[] = $r;
}

echo json_encode($rows);
	
include '../../close.php';

?>