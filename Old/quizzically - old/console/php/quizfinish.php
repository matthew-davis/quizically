<?php
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';

$quizcode = $link->real_escape_string($_POST["quiz_code"]);

//Get QUIZ_ID
$sql = "SELECT QUIZ_ID FROM B_QUIZ WHERE QUIZ_CODE = '$quizcode'";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
	$quizid = $row['QUIZ_ID'];
}

$sql = "SELECT QUESTION, CORRECT_ANSWER	   
			FROM B_QUESTION a, B_GAME b		
			WHERE a.QUESTION_ID = b.QUESTION_ID
			AND b.QUIZ_ID = $quizid
			ORDER BY b.GAME_ID ASC";
$res = $link->query($sql);

$rows = array();

while ($r = $res->fetch_assoc()) {
	$rows[] = $r;
}

echo json_encode($rows);
	
include '../../close.php';

?>