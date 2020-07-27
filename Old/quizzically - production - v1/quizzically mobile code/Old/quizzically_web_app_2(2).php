<?PHP
	session_start();
	include 'open.php';
	
	if($_SERVER['REQUEST_METHOD'] == "GET") {

		$_SESSION['quest_id'] = 0;
		$_SESSION['difficulty'] = $_GET['quiz_difficulty'];
		$_SESSION['code'] = $_GET['quiz_code'];
		$_SESSION['questions'] = $_GET['quiz_questions'];
		
		$query1 = sprintf("INSERT INTO P_QUIZ VALUES (null, %d, '%s', %d, null, '%s', 'N', %d, %d)", $_SESSION['questions'], $_SESSION['code'], $_SESSION['difficulty'], $_GET['quiz_location'], $_SESSION['questions'], $_SESSION['quest_id']);	
	
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
		
			echo "Here's the quiz code you need to register:  <b>" . $_SESSION['code'] . "</b><br><br>";
			
			if(isset($_GET['Submit1'])) {
			
				require 'start.php';
			
			}
			
			if(isset($_POST['Submit2'])) {
			
				$query2 = sprintf("SELECT a.QUEST_ID, a.QUESTION, a.QUEST_CATEGORY, b.ANS_A, b.ANS_B, b.ANS_C, b.ANS_D, b.ANS_CORRECT 
									FROM P_QUESTIONS a, P_ANSWERS b, (SELECT MIN(QUEST_ID) AS QUEST_ID FROM P_QUESTIONS WHERE QUEST_ID > %d AND QUEST_DIFFICULTY = %d) c 
									WHERE a.QUEST_ID = b.QUEST_ID
									AND a.QUEST_ID = c.QUEST_ID
									GROUP BY a.QUESTION, a.QUEST_CATEGORY, b.ANS_A, b.ANS_B, b.ANS_C, b.ANS_D, b.ANS_CORRECT", $_SESSION['quest_id'], $_SESSION['difficulty']);	
			
				$result2 = mysql_query($query2);
		
				while ($row1 = mysql_fetch_assoc($result2)) {

					$category = $row1['QUEST_CATEGORY'];
					$question = $row1['QUESTION'];
					$ans_a = $row1['ANS_A'];
					$ans_b = $row1['ANS_B'];
					$ans_c = $row1['ANS_C'];
					$ans_d = $row1['ANS_D'];
					$ans_correct = $row1['ANS_CORRECT'];				
					$_SESSION['quest_id'] = $row1['QUEST_ID'];

				}
				
				$query3 = sprintf("UPDATE P_QUIZ SET QUEST_ID = %d WHERE QUIZ_CODE = '%s'", $_SESSION['quest_id'], $_SESSION['code']); 
				
				mysql_query($query3);
				
				$query4 = sprintf("SELECT QUIZ_CURRENT FROM P_QUIZ WHERE QUIZ_CODE = '%s'", $_SESSION['code']);	
			
				$result4 = mysql_query($query4);
		
				while ($row1 = mysql_fetch_assoc($result4)) {

					$temp_question = $row1['QUIZ_CURRENT'];

				}				
				
				require 'question1.php';
			
			}
			
			
			if(isset($_POST['Submit3'])) {
		
				$query2 = sprintf("SELECT a.QUEST_ID, a.QUESTION, a.QUEST_CATEGORY, b.ANS_A, b.ANS_B, b.ANS_C, b.ANS_D, b.ANS_CORRECT 
									FROM P_QUESTIONS a, P_ANSWERS b, (SELECT MIN(QUEST_ID) AS QUEST_ID FROM P_QUESTIONS WHERE QUEST_ID = %d AND QUEST_DIFFICULTY = %d) c 
									WHERE a.QUEST_ID = b.QUEST_ID
									AND a.QUEST_ID = c.QUEST_ID
									GROUP BY a.QUESTION, a.QUEST_CATEGORY, b.ANS_A, b.ANS_B, b.ANS_C, b.ANS_D, b.ANS_CORRECT", $_SESSION['quest_id'], $_SESSION['difficulty']);	
			
				$result2 = mysql_query($query2);
		
				while ($row1 = mysql_fetch_assoc($result2)) {

					$category = $row1['QUEST_CATEGORY'];
					$question = $row1['QUESTION'];
					$ans_a = $row1['ANS_A'];
					$ans_b = $row1['ANS_B'];
					$ans_c = $row1['ANS_C'];
					$ans_d = $row1['ANS_D'];
					$ans_correct = $row1['ANS_CORRECT'];				
					$_SESSION['quest_id'] = $row1['QUEST_ID'];

				}
				
				$query3 = sprintf("UPDATE P_QUIZ SET QUIZ_STATUS = 'R' WHERE QUIZ_CODE = '%s'", $_SESSION['code']); 
				
				mysql_query($query3);
				
				$query4 = sprintf("SELECT QUIZ_CURRENT FROM P_QUIZ WHERE QUIZ_CODE = '%s'", $_SESSION['code']);	
			
				$result4 = mysql_query($query4);
		
				while ($row1 = mysql_fetch_assoc($result4)) {

					$temp_question = $row1['QUIZ_CURRENT'];

				}
				
				require 'question2.php';
			
			}
			
			if(isset($_POST['Submit4']) or isset($_POST['Submit6'])) {
		
				$query2 = sprintf("SELECT a.QUEST_ID, a.QUESTION, a.QUEST_CATEGORY, b.ANS_A, b.ANS_B, b.ANS_C, b.ANS_D, b.ANS_CORRECT 
									FROM P_QUESTIONS a, P_ANSWERS b, (SELECT MIN(QUEST_ID) AS QUEST_ID FROM P_QUESTIONS WHERE QUEST_ID > %d AND QUEST_DIFFICULTY = %d) c 
									WHERE a.QUEST_ID = b.QUEST_ID
									AND a.QUEST_ID = c.QUEST_ID
									GROUP BY a.QUESTION, a.QUEST_CATEGORY, b.ANS_A, b.ANS_B, b.ANS_C, b.ANS_D, b.ANS_CORRECT", $_SESSION['quest_id'], $_SESSION['difficulty']);	
			
				$result2 = mysql_query($query2);
		
				while ($row1 = mysql_fetch_assoc($result2)) {

					$category = $row1['QUEST_CATEGORY'];
					$question = $row1['QUESTION'];
					$ans_a = $row1['ANS_A'];
					$ans_b = $row1['ANS_B'];
					$ans_c = $row1['ANS_C'];
					$ans_d = $row1['ANS_D'];
					$ans_correct = $row1['ANS_CORRECT'];				
					$_SESSION['quest_id'] = $row1['QUEST_ID'];

				}
				
				$query3 = sprintf("UPDATE P_QUIZ SET QUIZ_CURRENT = QUIZ_CURRENT - 1, QUEST_ID = %d, QUIZ_STATUS = 'N' WHERE QUIZ_CODE = '%s'", $_SESSION['quest_id'], $_SESSION['code']); 
				
				mysql_query($query3);
				
				$query4 = sprintf("SELECT QUIZ_CURRENT FROM P_QUIZ WHERE QUIZ_CODE = '%s'", $_SESSION['code']); 
				
				$result4 = mysql_query($query4);
				
				while ($row2 = mysql_fetch_assoc($result4)) {
				
					$temp_question = $row2['QUIZ_CURRENT'];
				
				}
				
				if ($temp_question > 0) {
				
					require 'question1.php';
				
				} else {
				
					$query3 = sprintf("UPDATE P_QUIZ SET QUIZ_STATUS = 'F' WHERE QUIZ_CODE = '%s'", $_SESSION['code']); 
				
					mysql_query($query3);
				
					require 'finish.php';
				
				}
			
			}
			
			if(isset($_POST['Submit5'])) {
		
				$query3 = sprintf("UPDATE P_QUIZ SET QUIZ_STATUS = 'I' WHERE QUIZ_CODE = '%s'", $_SESSION['code']); 
				
				mysql_query($query3);
				
				$query4 = sprintf("SELECT QUIZ_CURRENT FROM P_QUIZ WHERE QUIZ_CODE = '%s'", $_SESSION['code']);	
			
				$result4 = mysql_query($query4);
		
				while ($row1 = mysql_fetch_assoc($result4)) {

					$temp_question = $row1['QUIZ_CURRENT'];

				}
		
				require 'intermission.php';
			
			}
			
			include 'close.php';
		
		?>
	
	</body>

</html>
