<?php
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';

$email = $link->real_escape_string($_POST["home_email"]);

$sql = "SELECT x.DATE, y.WINNER
			FROM (SELECT QUIZ_ID, DATE_FORMAT(QUIZ_COMPLETED, '%d-%b-%Y') AS DATE, QUIZ_COMPLETED
					FROM B_QUIZ 
					WHERE CLIENT_ID IN (SELECT CLIENT_ID FROM A_CLIENT WHERE CLIENT_EMAIL = '$email') 
					AND QUIZ_ID IN (SELECT DISTINCT QUIZ_ID FROM B_PARTICIPANT) 
					ORDER BY QUIZ_COMPLETED DESC 
					LIMIT 3) x,
				 (SELECT a.QUIZ_ID, b.NAME AS WINNER 
					FROM B_PARTICIPANT a, 
						 (SELECT USER_ID, SUBSTRING(USER_EMAIL, 1, LOCATE('@', USER_EMAIL) - 1) AS NAME FROM A_USER) b,
						 (SELECT QUIZ_ID, MAX(SCORE) AS SCORE FROM B_PARTICIPANT GROUP BY QUIZ_ID) c 
					WHERE a.USER_ID = b.USER_ID
					AND a.QUIZ_ID = c.QUIZ_ID
					AND a.SCORE = c.SCORE) y
			WHERE x.QUIZ_ID = y.QUIZ_ID
			ORDER BY QUIZ_COMPLETED ASC";
$res = $link->query($sql);

$rows = array();

while ($r = $res->fetch_assoc()) {
	$rows[] = $r;
}

echo json_encode($rows);
	
include '../../close.php';

?>