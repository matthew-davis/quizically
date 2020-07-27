<?php

/************************************CONFIG****************************************/
//DATABSE DETAILS//
$DB_ADDRESS = "localhost";
$DB_USER = "taysidek_quiz";
$DB_PASS = "Dsf%!1707";
$DB_NAME = "taysidek_quizzically";

//SETTINGS//
$SQLKEY = "onceisawabear";
/************************************CONFIG****************************************/

//These are just in case setting headers forcing it to always expire and set the content type to JSON
header('Cache-Control: no-cache, must-revalidate');
header('Content-type: application/json');
header('Content-Disposition: attachment; filename="JSON"');

//Checks if the tag post is there and if its been properly formatted
if(isset($_POST['tag']) && ($_SERVER['CONTENT_TYPE'] == "application/x-www-form-urlencoded")) {  
    
	$tag = $_POST['tag'];
    
	//Splits the app values from the SQLKEY
	$data = explode("|||", $tag);   
	
	//Validates the SQLKEY
	if($data[0] == $SQLKEY) {  

		//Check if the worthless pile of crap magic quotes is enabled and if it is strip the slashes from the values	
		if(get_magic_quotes_gpc()) {     
            
			$QuizCode = stripslashes($data[1]);
			$UserEmail = stripslashes($data[2]);
			$UserName = stripslashes($data[3]);
			$UserGender = stripslashes($data[4]);
			$UserDOB = stripslashes($data[5]);
			$UserNotify = stripslashes($data[6]);
			
		}
		
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
		
		
		//Connect to the MySQL database
		$link = mysql_connect($DB_ADDRESS, $DB_USER, $DB_PASS);   
        
		//Connect to the right schema
		mysql_select_db($DB_NAME, $link);                        
        
		
		if($link) {
			
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
            
            //Close the database
			mysql_close($link);     
          
		} else {
		
		    //Reports a database connection failure
		    echo json_encode(array("VALUE", $tag, array("ERROR - Database Connection Failed"))); 
			
		}

    } else {
	
	    //Reports if the SQLKEY is bad
	    echo json_encode(array("VALUE", $tag, array("ERROR - Bad SQL Key Supplied")));  
	
    } 
}

?>