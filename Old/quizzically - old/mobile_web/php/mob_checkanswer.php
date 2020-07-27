<?PHP

include '../../open.php';

//take in POST variables
$points = $link->real_escape_string($_POST["mob_checkanswer_score"]);
$questionid = $link->real_escape_string($_POST["mob_checkanswer_questionid"]);
$quizcode = $link->real_escape_string($_POST["mob_checkanswer_quizcode"]);
$email = $link->real_escape_string($_POST["mob_checkanswer_email"]);
$password = $link->real_escape_string($_POST["mob_checkanswer_password"]);
$answer = $link->real_escape_string($_POST["mob_checkanswer"]);

$quizid = 0;

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

$answeredbefore = 0;
$sql = "SELECT 1 FROM C_INTERACTION WHERE PARTICIPANT_ID = $participantid AND QUESTION_ID = $questionid";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
    $answeredbefore = $row['1'];
}

if ($quizid != 0) {
	$sql = "SELECT CORRECT_ANSWER FROM B_QUESTION WHERE QUESTION_ID = $questionid";
	$res = $link->query($sql);
	while ($row = $res->fetch_array()) {
		$correct = $row['CORRECT_ANSWER'];
	}
	
	if ($answeredbefore == 0)  {
	
		$checkedanswer = 0;
	
		if ($answer == $correct) {
			$sql = "UPDATE B_PARTICIPANT SET SCORE = SCORE + $points WHERE USER_ID = $userid AND QUIZ_ID = $quizid";
			$res = $link->query($sql);
			
			$checkedanswer = 1;	
		}
		
		$sql = "SELECT PARTICIPANT_ID, SCORE FROM B_PARTICIPANT WHERE USER_ID = $userid AND QUIZ_ID = $quizid";
		$res = $link->query($sql);
		while ($row = $res->fetch_array()) {
			$participantid = $row['PARTICIPANT_ID'];
			$score = $row['SCORE'];
		}
			
		$sql = "INSERT INTO C_INTERACTION (PARTICIPANT_ID, QUESTION_ID, SELECTED_ANSWER, CORRECT, CURRENT_SCORE, INTERACTION_DATE)	
					VALUES ($participantid, $questionid, '$answer', $checkedanswer, $score, SYSDATE())";
		$res = $link->query($sql);
	
	}

	$arr = array("mob_checkanswer_success" => "mob checkanswer success");
	echo json_encode($arr);
	
} else {
	$arr = array("mob_checkanswer_success" => "mob checkanswer failed");
	echo json_encode($arr);
}

include '../../close.php';

?>