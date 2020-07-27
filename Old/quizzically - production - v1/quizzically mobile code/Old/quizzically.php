<?php

include 'open.php';

/************************************CONFIG****************************************/
$SQLKEY = "onceisawabear";

//These are just in case setting headers forcing it to always expire and set the content type to JSON
header('Cache-Control: no-cache, must-revalidate');
header('Content-type: application/json');
header('Content-Disposition: attachment; filename="JSON"');
/************************************CONFIG****************************************/

//Checks if the tag post is there and if its been properly formatted
if(isset($_POST['tag']) && ($_SERVER['CONTENT_TYPE'] == "application/x-www-form-urlencoded")) {  
    
	$tag = $_POST['tag'];
    
	//Splits the app values from the SQLKEY
	$data = explode("|||", $tag);   
	
	//Validates the SQLKEY
	if($data[0] == $SQLKEY) {  

		//Check if the worthless pile of crap magic quotes is enabled and if it is strip the slashes from the value	
		if(get_magic_quotes_gpc()) {     
            $type = stripslashes($data[1]);
        
		    //Detemines the type of request to either initialize or next question 
		    if($type == "quiz") {
			
				$QuizCode = stripslashes($data[2]);
				$UserEmail = stripslashes($data[3]);
				$UserName = stripslashes($data[4]);
				$UserGender = stripslashes($data[5]);
				$UserDOB = stripslashes($data[6]);
				$UserNotify = stripslashes($data[7]);
			
		        //Check for quiz
				$query1 = sprintf("SELECT 1 FROM P_QUIZ WHERE QUIZ_CODE = '%s'", $QuizCode);

				//Check for user details
				$query2 = sprintf("SELECT 1 FROM P_USERS WHERE USE_EMAIL = '%s'", $UserEmail);

				//Check if participant already
				$query3 = sprintf("SELECT 1 FROM P_PARTICIPANTS WHERE USE_ID = (SELECT USE_ID FROM P_USERS WHERE USE_EMAIL = '%s') AND QUIZ_ID = (SELECT QUIZ_ID FROM P_QUIZ WHERE QUIZ_CODE = '%s')", $UserEmail, $QuizCode);
				
				//Set as participant
				$query4 = sprintf("INSERT INTO P_PARTICIPANTS SELECT null, a.USE_ID, b.QUIZ_ID, 0, null FROM (SELECT USE_ID FROM P_USERS WHERE USE_EMAIL = '%s') a, (SELECT QUIZ_ID FROM P_QUIZ WHERE QUIZ_CODE = '%s') b", $UserEmail, $QuizCode);

				//Put details into the MySQL database
				$query5 = sprintf("INSERT INTO P_USERS SELECT null, '%s', '%s', '%s', null, '%s' FROM DUAL", $UserEmail, $UserName, $UserGender, $UserNotify);
			
				//See if the quiz exists
				$result1 = mysql_query($query1);
			
				if(mysql_num_rows($result1) > 0) {
			
					//check if user details in database
					$result2 = mysql_query($query2);
			
					if(mysql_num_rows($result2) > 0) {
				
						//check if already listed as a participant
						$result3 = mysql_query($query3);
			
						if(mysql_num_rows($result3) > 0) { 
					
							//Returns "(1 1)" to let the user go through to quiz
							echo json_encode(array("VALUE", $tag, mysql_fetch_array($result1)));
						
						} else {
					
							//Put details in participant table
							mysql_query($query4);
							
							//Returns "(1 1)" to let the user go through to quiz
							echo json_encode(array("VALUE", $tag, mysql_fetch_array($result1)));
						
						}
				
					} else {
				
						//Put details in user table
						mysql_query($query5);
						
						//Put details in participant table
						mysql_query($query4);
						
						//Returns "(1 1)" to let the user go through to quiz
						echo json_encode(array("VALUE", $tag, mysql_fetch_array($result1)));
					
					}
				
				} else {
				
					//Errors if the quiz isn't listed
					echo json_encode(array("VALUE", $tag, array("Quiz not activated"))); 
					
				}
			
            } elseif($type == "check") {
			
				$quizcode = stripslashes($data[2]);
				$email = stripslashes($data[3]);
		
		        //Get the question and answer
			    $query = sprintf("SELECT a.QUIZ_CURRENT, a.QUIZ_STATUS, CAST( b.PART_SCORE AS CHAR ) AS PART_SCORE, d.QUESTION, d.QUEST_CATEGORY, e.ANS_A, e.ANS_B, e.ANS_C, e.ANS_D, e.ANS_CORRECT
									FROM P_QUIZ a, P_PARTICIPANTS b, P_USERS c, P_QUESTIONS d, P_ANSWERS e
									WHERE a.QUIZ_ID = b.QUIZ_ID
									AND b.USE_ID = c.USE_ID
									AND a.QUEST_ID = d.QUEST_ID
									AND d.QUEST_ID = e.QUEST_ID
									AND a.QUIZ_CODE = '%s'
									AND c.USE_EMAIL = '%s'", $quizcode, $email);
									
				//runs the SQL query
				$result = mysql_query($query);                    
				
				if(mysql_num_rows($result) > 0) {
					
					//Sends out a JSON result with merged output data
					echo json_encode(array("VALUE", $tag, mysql_fetch_array($result))); 
				   
				} else {
				
					//Errors if the query is bad and spits the error back to the client
					echo json_encode(array("VALUE", $tag, array_merge(array(array(mysql_errno($link).": ".mysql_error($link)))))); 
				}
			
			} elseif($type == "answer") {
			
				$score = intval(stripslashes($data[2]));
				$user = stripslashes($data[3]);
				$quiz = stripslashes($data[4]);
			
		        //Send the score back to the database
			    $query1 = sprintf("UPDATE P_PARTICIPANTS a, P_USERS b, P_QUIZ c
									SET a.PART_SCORE = a.PART_SCORE + %d
									WHERE a.USE_ID = b.USE_ID
									AND a.QUIZ_ID = c.QUIZ_ID
									AND b.USE_EMAIL = '%s'
									AND c.QUIZ_CODE = '%s'", $score, $user, $quiz);
				
				$query2 = sprintf("SELECT a.PART_SCORE 
									FROM P_PARTICIPANTS a, P_USERS b, P_QUIZ c 
									WHERE a.USE_ID = b.USE_ID
									AND a.QUIZ_ID = c.QUIZ_ID
									AND c.QUIZ_CODE = '%s'									
									AND b.USE_EMAIL = '%s'", $quiz, $user);
									
				//runs the SQL query
				mysql_query($query1); 

				$result = mysql_query($query2);
				
				
				if(mysql_num_rows($result) > 0) {
					
					//Sends out a JSON result with merged output data
					echo json_encode(array("VALUE", $tag, mysql_fetch_array($result))); 
				   
				} else {
				
					//Errors if the query is bad and spits the error back to the client
					echo json_encode(array("VALUE", $tag, array_merge(array(array(mysql_errno($link).": ".mysql_error($link)))))); 
				}
			
			}
		
		}
		
		include 'close.php';     

    } else {
	
	    //Reports if the SQLKEY is bad
	    echo json_encode(array("VALUE", $tag, array("ERROR - Bad SQL Key Supplied")));  
	
    } 
}

?>