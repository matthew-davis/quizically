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
		    if($data[1] == "answer") {
			
				$score = stripslashes($data[2]);
				$user = stripslashes($data[3]);
						
		        //Set query to retrive the initial question / answer pair
			    $query = sprintf("UPDATE P_PARTICIPANTS a LEFT JOIN P_USERS b ON a.USE_ID = b.USE_ID
									SET a.PART_SCORE = %d
									WHERE b.USE_EMAIL = '%s'", $score, $user);
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

