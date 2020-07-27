<?php
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';

$status = $link->real_escape_string($_POST["quiz_status"]);
$quizcode = $link->real_escape_string($_POST["quiz_code"]);

//Get QUIZ_ID
$sql = "SELECT QUIZ_ID FROM B_QUIZ WHERE QUIZ_CODE = '$quizcode'";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
	$quizid = $row['QUIZ_ID'];
}

//Update B_GAME
$sql = "UPDATE B_GAME a INNER JOIN (SELECT MAX(GAME_ID) AS GAME_ID FROM B_GAME WHERE QUIZ_ID = $quizid) b ON a.GAME_ID = b.GAME_ID
		    SET a.QUIZ_STATUS = 'I'
			WHERE a.QUIZ_ID = $quizid";
	$res = $link->query($sql);

include '../../close.php';

?>