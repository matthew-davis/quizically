<?php

/************************************CONFIG****************************************/
//DATABSE DETAILS//
$DB_ADDRESS = "localhost";
$DB_USER = "taysidek_testacc";
$DB_PASS = "Dsf%!1707";
$DB_NAME = "taysidek_testdb";

//SETTINGS//
//This code is something you set in the APP so random people can't use it
$SQLKEY = "randomkey";
/************************************CONFIG****************************************/

//These are just in case setting headers forcing it to always expire and set the content type to JSON
header('Cache-Control: no-cache, must-revalidate');
header('Content-type: application/json');
header('Content-Disposition: attachment; filename="JSON"');

//Checks if the tag post is there and if its been properly formatted
if(isset($_POST['tag']) && ($_SERVER['CONTENT_TYPE'] == "application/x-www-form-urlencoded")) {  
    $tag = $_POST['tag'];
    
	//Splits the request value from the SQLKEY
	$data = explode("|||", $tag);   
    
	//Validates the SQLKEY
	if($data[0] == $SQLKEY) {  

		//Check if the worthless pile of crap magic quotes is enabled and if it is strip the slashes from the value	
		if(get_magic_quotes_gpc()){     
            $data[1] = stripslashes($data[1]);
        
		    //Detemines the type of request to either initialize or next question 
		    if($data[1] == "check") {
			
				$quizcode = stripslashes($data[2]);
				$email = stripslashes($data[3]);
		
		        //Set query to retrive the initial question / answer pair
			    $query = sprintf("SELECT a.QUIZ_CURRENT, a.QUIZ_STATUS, b.PART_SCORE, d.QUESTION, d.QUEST_CATEGORY, e.ANS_A, e.ANS_B, e.ANS_C, e.ANS_D, e.ANS_CORRECT
									FROM P_QUIZ a, P_PARTICIPANTS b, P_USERS c, P_QUESTIONS d, P_ANSWERS e
									WHERE a.QUIZ_ID = b.QUIZ_ID
									AND b.USE_ID = c.USE_ID
									AND a.QUEST_ID = d.QUEST_ID
									AND d.QUEST_ID = e.QUEST_ID
									AND a.QUIZ_CODE = %s
									AND c.USE_EMAIL = %s", $quizcode, $email);
            }
			
		}
        
		//Connect to the MySQL database
		$link = mysql_connect($DB_ADDRESS, $DB_USER, $DB_PASS);   
        
		//Connect to the right database
		mysql_select_db($DB_NAME, $link);                        
        
		if($link) {
            
			//runs the SQL query
			$result = mysql_query($query);                    
            
			if($result) {
                
				//Sets up an array
				$outputdata = array();
					
                while ($row = mysql_fetch_assoc($result)) {
                        
				    //Formats the result set to a valid array
					$outputdata[] = $row;             
                }
                    
				//Sends out a JSON result with merged output data
				echo json_encode(array("VALUE", $tag, array_merge($outputdata))); 
               
            } else {
			
			    //Errors if the query is bad and spits the error back to the client
			    echo json_encode(array("VALUE", $tag, array_merge(array(array(mysql_errno($link).": ".mysql_error($link)))))); 
            }
			
			//Close the database
			mysql_close($link);     
        
		       
		} else {
		
		    //Reports a database connection failure
		    echo json_encode(array("VALUE",$tag,array_merge(array(array("ERROR Database Connection Failed"))))); 
		}

    } else {
        
		//Reports if the SQLKEY is bad
		echo json_encode(array("VALUE", $tag, array_merge(array(array("ERROR BAD SQLKEY SUPPLIED")))));     
    }
}
?>

