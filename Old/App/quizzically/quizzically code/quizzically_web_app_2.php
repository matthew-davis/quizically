<?PHP
	session_start();
	include 'open.php';
	
	if(isset($_POST['Submit1'])) {

		$_SESSION['quest_id'] = 0;
		$_SESSION['difficulty'] = $_POST['quiz_difficulty'];
		$_SESSION['code'] = $_POST['quiz_code'];
		$_SESSION['questions'] = $_POST['quiz_questions'];

		$query1 = sprintf("INSERT INTO P_QUIZ VALUES (null, %d, '%s', %d, null, '%s', 'N', %d)", $_POST['quiz_questions'], $_POST['quiz_code'], $_POST['quiz_difficulty'], $_POST['quiz_location']. $_POST['quiz_questions']);	
	
		$result1 = mysql_query($query1);

	}

?>

<html>

	<head>
	
		<title>quizzically Web App</title>
		
	</head>

	<body>

		<img src="logo.png"><br><br><br>
	
		<?PHP
		
			echo $_SESSION['code'] . "<br><br>";
		
			$query2 = sprintf("SELECT a.QUEST_ID, a.QUESTION, a.QUEST_CATEGORY, b.ANS_A, b.ANS_B, b.ANS_C, b.ANS_D, b.ANS_CORRECT 
								FROM P_QUESTIONS a, P_ANSWERS b, (SELECT MIN(QUEST_ID) AS QUEST_ID FROM P_QUESTIONS WHERE QUEST_ID > %d AND QUEST_DIFFICULTY = %d) c 
								WHERE a.QUEST_ID = b.QUEST_ID
								AND a.QUEST_ID = c.QUEST_ID
								GROUP BY a.QUESTION, a.QUEST_CATEGORY, b.ANS_A, b.ANS_B, b.ANS_C, b.ANS_D, b.ANS_CORRECT", $_SESSION['quest_id'], $_SESSION['difficulty']);	
			
			$result2 = mysql_query($query2);
	
			while ($row = mysql_fetch_assoc($result2)) {

				$category = $row['QUEST_CATEGORY'];
				$question = $row['QUESTION'];
				$ans_a = $row['ANS_A'];
				$ans_b = $row['ANS_B'];
				$ans_c = $row['ANS_C'];
				$ans_d = $row['ANS_D'];
				$ans_correct = $row['ANS_CORRECT'];				
				$_SESSION['quest_id'] = $row['QUEST_ID'];

			}
			
			include 'close.php';
			
			$_SESSION['questions'] = $_SESSION['questions'] - 1;
			
			if ($_SESSION['questions'] > 0) {
			
				require 'question.php';
			
			} else {
			
				require 'finish.php';
			
			}
		
		?>
	
	</body>

</html>

