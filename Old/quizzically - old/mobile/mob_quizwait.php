<?PHP

include '../open.php';

//take in POST variables
$quizcode = $link->real_escape_string($_POST["mob_quizwait_quizcode"]);
$email = $link->real_escape_string($_POST["mob_quizwait_email"]);
$password = $link->real_escape_string($_POST["mob_quizwait_password"]);
$questionid1 = $link->real_escape_string($_POST["mob_quizwait_questionid"]);

$quizid = 0;
$status = "X";
$questionid = 0;

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

$sql = "SELECT a.QUIZ_STATUS, IFNULL(a.QUESTION_ID, 0) AS QUESTION_ID 
		   FROM B_GAME a 
		   WHERE a.QUIZ_ID = $quizid
		   AND a.GAME_ID IN (SELECT MAX(b.GAME_ID) FROM B_GAME b WHERE a.QUIZ_ID = b.QUIZ_ID)";
$res = $link->query($sql);

while ($row = $res->fetch_array()) {
    $status = $row['QUIZ_STATUS'];
	$questionid = $row['QUESTION_ID'];
}

if ($questionid == $questionid1) {
	$questionid = 0;
}

if ($status != "F") {
	if ($quizid != 0 && $status != "X") {
		//get details to be written to the profile page
		if ($questionid != 0) {
		
			$sql = "SELECT SCORE FROM B_PARTICIPANT WHERE USER_ID = $userid AND QUIZ_ID = $quizid";
			$res = $link->query($sql);

			while ($row = $res->fetch_array()) {
				$score = $row['SCORE'];
			}
			
			$sql = "SELECT b.QUESTION_ID, c.CATEGORY, b.QUESTION, b.CORRECT_ANSWER, b.WRONG_ANSWER_1, b.WRONG_ANSWER_2, b.WRONG_ANSWER_3
						FROM B_GAME a, B_QUESTION b, D_CATEGORY c
						WHERE a.QUESTION_ID = b.QUESTION_ID
						AND b.CATEGORY_ID = c.CATEGORY_ID
						AND a.QUIZ_ID = $quizid
						AND a.GAME_ID IN (SELECT MAX(d.GAME_ID) FROM B_GAME d WHERE a.QUIZ_ID = d.QUIZ_ID)";	
			$res = $link->query($sql);

			while ($row = $res->fetch_array()) {
				$questionid = $row['QUESTION_ID'];
				$category = $row['CATEGORY'];
				$question = $row['QUESTION'];
				$correct = $row['CORRECT_ANSWER'];
				$wrong1 = $row['WRONG_ANSWER_1'];
				$wrong2 = $row['WRONG_ANSWER_2'];
				$wrong3 = $row['WRONG_ANSWER_3'];
			}
			
			if ($status == "R") {
				$arr = array("mob_quizwait_success" => "mob quizwait go", 
							 "mob_quizwait_questionid" => $questionid,
							 "mob_quizwait_score" => $score, 
							 "mob_quizwait_category" => $category, 
							 "mob_quizwait_question" => $question, 
							 "mob_quizwait_correct" => $correct, 
							 "mob_quizwait_wrong1" => $wrong1, 
							 "mob_quizwait_wrong2" => $wrong2,
							 "mob_quizwait_wrong3" => $wrong3);
				echo json_encode($arr);
			} else if ($status == "N") {
				$arr = array("mob_quizwait_success" => "mob quizwait stay");
				echo json_encode($arr);
			} else if ($status == "I") {
				$arr = array("mob_quizwait_success" => "mob quizwait intermission");
				echo json_encode($arr);
			}
		} else if ($status == "I") {
			$arr = array("mob_quizwait_success" => "mob quizwait intermission");
			echo json_encode($arr);
		} else {
			$arr = array("mob_quizwait_success" => "mob quizwait stay");
			echo json_encode($arr);
		}
	} else {
		$arr = array("mob_quizwait_success" => "mob quizwait failed");
		echo json_encode($arr);
	}
	
} else {
	$arr = array("mob_quizwait_success" => "mob quizwait finished");
	echo json_encode($arr);
}

include '../close.php';

?>