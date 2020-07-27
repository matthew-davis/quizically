<?php
//
//Matthew Davis
//11/03/2014
//
include '../open.php';

$quizcode = $link->real_escape_string($_POST["mob_quizcode"]);

$sql = "SELECT SUBSTRING(b.USER_EMAIL, 1, LOCATE('@', b.USER_EMAIL) - 1) AS NAME, a.SCORE	   
			FROM B_PARTICIPANT a, A_USER b			
			WHERE a.USER_ID = b.USER_ID
			AND a.QUIZ_ID IN (SELECT QUIZ_ID FROM B_QUIZ WHERE QUIZ_CODE = '$quizcode')
			ORDER BY a.SCORE ASC
			LIMIT 5";
$res = $link->query($sql);

$rows = array();

while ($r = $res->fetch_assoc()) {
	$rows[] = $r;
}

echo json_encode($rows);
	
include '../close.php';

?>