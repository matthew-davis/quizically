<?php
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';

$quizcode = $link->real_escape_string($_POST["quiz_code"]);

$sql = "SELECT IFNULL(y.QUESTION_ID, 1) AS QUESTION_ID
			FROM B_QUIZ x
    				INNER JOIN (SELECT a.QUESTION_ID, 
									   a.QUIZ_ID 
									FROM B_GAME a
    										INNER JOIN (SELECT MAX(GAME_ID) AS GAME_ID, 
													   		   QUIZ_ID 
															FROM B_GAME 
															GROUP BY QUIZ_ID) b ON a.GAME_ID = b.GAME_ID) y ON x.QUIZ_ID = y.QUIZ_ID
            
    		WHERE x.QUIZ_CODE = '$quizcode'";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
	$questionid = $row['QUESTION_ID'];
}

$sql = "SELECT SUBSTRING(b.USER_EMAIL, 1, LOCATE('@', b.USER_EMAIL) - 1) AS NAME,
			   a.SCORE,
			   CASE WHEN IFNULL(c.ANSWERED, 0) = 0 THEN 'Waiting'
			   		WHEN IFNULL(c.ANSWERED, 0) = 1 THEN 'Answered'
					END AS ANSWERED,			   
			   CASE WHEN IFNULL(c.CORRECT, -1) = 1 THEN 'Correct'
			   		WHEN IFNULL(c.CORRECT, -1) = -1 THEN 'Start'
			   		WHEN IFNULL(c.CORRECT, -1) = 0 THEN 'Incorrect'
					END AS CLASS
			   	   
			FROM B_PARTICIPANT a
					LEFT JOIN A_USER b ON a.USER_ID = b.USER_ID
					LEFT JOIN (SELECT 1 AS ANSWERED, CORRECT, PARTICIPANT_ID FROM C_INTERACTION WHERE QUESTION_ID = $questionid) c ON a.PARTICIPANT_ID = c.PARTICIPANT_ID

			WHERE a.QUIZ_ID IN (SELECT QUIZ_ID FROM B_QUIZ WHERE QUIZ_CODE = '$quizcode')

			ORDER BY a.SCORE DESC";
$res = $link->query($sql);

$rows = array();

while ($r = $res->fetch_assoc()) {
	$rows[] = $r;
}

echo json_encode($rows);
	
include '../../close.php';

?>