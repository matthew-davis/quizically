<?PHP

//DATABASE DETAILS//
$DB_ADDRESS = "localhost";
$DB_USER = "root";
$DB_PASS = "password";
$DB_NAME = "quizzically";
	
//Connect to the MySQL database
$link = new mysqli($DB_ADDRESS, $DB_USER, $DB_PASS, $DB_NAME);

if($link->connect_errno > 0){
    die('Unable to connect to database [' . $link->connect_error . ']');
}                     

?>