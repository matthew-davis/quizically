<?php
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';

$email = $link->real_escape_string($_POST["question_email"]);
$password = $link->real_escape_string($_POST["question_password"]);
$type = $link->real_escape_string($_POST["question_type"]);
$status = $link->real_escape_string($_POST["question_status"]);
$quizcode = $link->real_escape_string($_POST["quiz_code"]);
$finished = 0;

//Get QUIZ_ID, QUESTION_LEFT, and DIFFICULTY_ID
$sql = "SELECT QUIZ_ID, IFNULL(NO_OF_QUESTIONS, 0) AS NO_OF_QUESTIONS, DIFFICULTY_ID FROM B_QUIZ WHERE QUIZ_CODE = '$quizcode'";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
	$quizid = $row['QUIZ_ID'];
	$questions = $row['NO_OF_QUESTIONS'];
	$difficulty = $row['DIFFICULTY_ID'];
}

$sql = "SELECT CLIENT_ID FROM A_CLIENT WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
$res = $link->query($sql);
while ($row = $res->fetch_array()) {
	$clientid = $row['CLIENT_ID'];
}

if ($type == "question") {
	$sql = "SELECT IFNULL(a.QUESTIONS_LEFT, 0) AS QUESTIONS_LEFT 
				FROM B_GAME a 
				WHERE a.QUIZ_ID = $quizid    
				AND a.GAME_ID IN (SELECT MAX(b.GAME_ID) FROM B_GAME b WHERE a.QUIZ_ID = b.QUIZ_ID)";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$finished = $row['QUESTIONS_LEFT'];
	}
	
	if ($finished != 0) {
		//Get a question
		$sql = "SELECT a.QUESTION_ID, b.CATEGORY, a.QUESTION, a.CORRECT_ANSWER, a.WRONG_ANSWER_1, a.WRONG_ANSWER_2, a.WRONG_ANSWER_3
					FROM B_QUESTION a
								INNER JOIN D_CATEGORY b ON a.CATEGORY_ID = b.CATEGORY_ID
								LEFT JOIN (SELECT QUESTION_ID FROM B_GAME WHERE QUIZ_ID = $quizid) c ON a.QUESTION_ID = c.QUESTION_ID
					WHERE a.DIFFICULTY_ID = $difficulty 
					AND c.QUESTION_ID IS NULL
					ORDER BY RAND() 
					LIMIT 1";
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

		--$finished;
		
		$questionsleft = $questions - $finished;
		
		//INSERT INTO B_GAME
		$sql = "INSERT INTO B_GAME (GAME_ID, QUIZ_ID, QUESTIONS_LEFT, DIFFICULTY_ID, QUESTION_ID, QUIZ_STATUS) VALUES (NULL, $quizid, $finished, $difficulty, $questionid, '$status')";
		$res = $link->query($sql);
		
		$arr = array("question_success" => "question success", "question_category" => $category, "question_number" => $questionsleft, "question_text" => $question, "question_correct" => $correct, "question_wrong1" => $wrong1, "question_wrong2" => $wrong2, "question_wrong3" => $wrong3);
		echo json_encode($arr);
		
	} else {
		//Update B_GAME
		$sql = "UPDATE B_GAME a
				   INNER JOIN (SELECT MAX(GAME_ID) AS GAME_ID FROM B_GAME WHERE QUIZ_ID = $quizid) b
				   ON a.GAME_ID = b.GAME_ID
				SET a.QUIZ_STATUS = 'F'
				WHERE a.QUIZ_ID = $quizid";
		$res = $link->query($sql);
		
		//Update B_QUIZ
		$sql = "UPDATE B_QUIZ SET QUIZ_COMPLETED = SYSDATE() WHERE QUIZ_ID = $quizid";
		$res = $link->query($sql);
		
		//Update A_CLIENT
		$sql = "UPDATE A_CLIENT SET QUIZ_HOSTED = QUIZ_HOSTED + 1 WHERE CLIENT_EMAIL = '$email' AND CLIENT_PASSWORD = '$password'";
		$res = $link->query($sql);
		
		$arr = array("question_success" => "quiz finished");
		echo json_encode($arr);
	}

} else if ($type == "release") {
	$sql = "SELECT IFNULL(a.QUESTIONS_LEFT, 0) AS QUESTIONS_LEFT
				FROM B_GAME a 
				WHERE a.QUIZ_ID = $quizid    
				AND a.GAME_ID IN (SELECT MAX(b.GAME_ID) FROM B_GAME b WHERE a.QUIZ_ID = b.QUIZ_ID)";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$finished = $row['QUESTIONS_LEFT'];
	}
	
	$questionsleft = $questions - $finished;	
	
	//Update B_GAME
	$sql = "UPDATE B_GAME a
				   INNER JOIN (SELECT MAX(GAME_ID) AS GAME_ID FROM B_GAME WHERE QUIZ_ID = $quizid) b
				   ON a.GAME_ID = b.GAME_ID
				SET a.QUIZ_STATUS = 'R'
				WHERE a.QUIZ_ID = $quizid";
	$res = $link->query($sql);
	
	$sql = "SELECT b.CATEGORY, a.QUESTION, a.CORRECT_ANSWER, a.WRONG_ANSWER_1, a.WRONG_ANSWER_2, a.WRONG_ANSWER_3
				FROM B_QUESTION a, D_CATEGORY b, B_GAME c
				WHERE a.CATEGORY_ID = b.CATEGORY_ID
				AND a.QUESTION_ID = c.QUESTION_ID
				AND c.QUIZ_ID = $quizid 
				AND c.GAME_ID IN (SELECT MAX(d.GAME_ID) FROM B_GAME d WHERE c.QUIZ_ID = d.QUIZ_ID)";
		$res = $link->query($sql);

		while ($row = $res->fetch_array()) {
			$category = $row['CATEGORY'];
			$question = $row['QUESTION'];
			$correct = $row['CORRECT_ANSWER'];
			$wrong1 = $row['WRONG_ANSWER_1'];
			$wrong2 = $row['WRONG_ANSWER_2'];
			$wrong3 = $row['WRONG_ANSWER_3'];
		}
	
	$arr = array("question_success" => "release success", "question_category" => $category, "question_number" => $questionsleft, "question_text" => $question, "question_correct" => $correct, "question_wrong1" => $wrong1, "question_wrong2" => $wrong2, "question_wrong3" => $wrong3);
	echo json_encode($arr);

} else if ($type == "intquestion") {
	$sql = "SELECT IFNULL(a.QUESTIONS_LEFT, 0) AS QUESTIONS_LEFT
				FROM B_GAME a 
				WHERE a.QUIZ_ID = $quizid    
				AND a.GAME_ID IN (SELECT MAX(b.GAME_ID) FROM B_GAME b WHERE a.QUIZ_ID = b.QUIZ_ID)";
	$res = $link->query($sql);

	while ($row = $res->fetch_array()) {
		$finished = $row['QUESTIONS_LEFT'];
	}
	
	$questionsleft = $questions - $finished;
	
	//Get a question
		$sql = "SELECT a.QUESTION_ID, b.CATEGORY, a.QUESTION, a.CORRECT_ANSWER, a.WRONG_ANSWER_1, a.WRONG_ANSWER_2, a.WRONG_ANSWER_3
					FROM B_QUESTION a
								INNER JOIN D_CATEGORY b ON a.CATEGORY_ID = b.CATEGORY_ID
								LEFT JOIN (SELECT QUESTION_ID FROM B_GAME WHERE QUIZ_ID = $quizid) c ON a.QUESTION_ID = c.QUESTION_ID
					WHERE a.DIFFICULTY_ID = $difficulty 
					AND c.QUESTION_ID IS NULL
					ORDER BY RAND() 
					LIMIT 1";
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
		
		//INSERT INTO B_GAME
		$sql = "INSERT INTO B_GAME (GAME_ID, QUIZ_ID, QUESTIONS_LEFT, DIFFICULTY_ID, QUESTION_ID, QUIZ_STATUS) VALUES (NULL, $quizid, $finished, $difficulty, $questionid, '$status')";
		$res = $link->query($sql);
		
		$arr = array("question_success" => "intquestion success", "question_category" => $category, "question_number" => $questionsleft, "question_text" => $question, "question_correct" => $correct, "question_wrong1" => $wrong1, "question_wrong2" => $wrong2, "question_wrong3" => $wrong3);
		echo json_encode($arr);
	
} else {
	$arr = array("question_success" => "question failed");
	echo json_encode($arr);
}

include '../../close.php';

?>