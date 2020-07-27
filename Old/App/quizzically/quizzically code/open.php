<?PHP

	//DATABASE DETAILS//
	$DB_ADDRESS = "localhost";
	$DB_USER = "taysidek_quiz";
	$DB_PASS = "Dsf%!1707";
	$DB_NAME = "taysidek_quizzically";
	
	//Connect to the MySQL database
	$link = mysql_connect($DB_ADDRESS, $DB_USER, $DB_PASS);   
	
	//Connect to the right schema
	mysql_select_db($DB_NAME, $link);                        

?>