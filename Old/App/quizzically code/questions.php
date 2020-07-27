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
	$data = explode("||||||", $tag);   
    
	//Validates the SQLKEY
	if($data[0] == $SQLKEY) {  

		//Check if the worthless pile of crap magic quotes is enabled and if it is strip the slashes from the value	
		if(get_magic_quotes_gpc()){     
            $data[1] = stripslashes($data[1]);
        
		    //Detemines the type of request to either initialize or next question 
		    if($data[1] == "initialize") {
		
		        //Set query to retrive the initial question / answer pair
			    $query = "SELECT b.QID, b.QUESTION, b.CATEGORY, c.ANSWERA, c.ANSWERB, c.ANSWERC, c.ANSWERD, c.CORRECTANSWER
							 FROM (SELECT MIN( QID ) AS STARTQ FROM QUESTIONS)a, QUESTIONS b, ANSWERS c
							 WHERE a.STARTQ = b.QID AND b.QID = c.QID";
		    } else {
			    $currentQID = (int)$data[1];
			    //Set query to retrieve next question
				$query = sprintf("SELECT a.QID, a.QUESTION, a.CATEGORY, b.ANSWERA, b.ANSWERB, b.ANSWERC, b.ANSWERD, b.CORRECTANSWER
							 FROM QUESTIONS a, ANSWERS b
							 WHERE a.QID = b.QID AND a.QID = %s + 1", $currentQID); 
            }
			
			//Lookup the motherfuckers username and password
			if($data[1] == "login") {
			
				$var1 = stripslashes($data[2]);
				$var2 = stripslashes($data[3]);
			
			    //Search query for user/pass
				$query = sprintf("SELECT FIRSTNAME
								  FROM USERS
								  WHERE USERNAME = '%s'
								  AND PASSWORD = '%s'", $var1, $var2);
			}
			
			//Register some new homies to the game!
			if($data[1] == "register") {
			
				$user = stripslashes($data[2]);
				$pass = stripslashes($data[3]);
				$firstname = stripslashes($data[4]);
				$lastname = stripslashes($data[5]);
				$email = stripslashes($data[6]);
				$gender = stripslashes($data[7]);
				$birthday = stripslashes($data[8]);
				
				$birthdate = DateTime::createFromFormat('d-m-Y', $birthday)->format('Y-m-d');
				
				//Put that shit in the database, like a boss
				$query = sprintf("INSERT INTO USERS VALUES (null, '%s', '%s', '%s', '%s', '%s', null, '%s', '%s')", 
								  $user, $pass, $firstname, $lastname, $gender, $email, $birthdate);
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

