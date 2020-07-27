<?PHP
/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

include '../../open.php';

$forgot_key = $link->real_escape_string($_POST['forgot_key']);
$apassword = $link->real_escape_string($_POST['change_password']);

$apassword = md5($apassword);

$sql = "UPDATE A_CLIENT SET RESET = NULL, EXPIRE = NULL, CLIENT_PASSWORD = '$apassword' WHERE RESET = '$forgot_key'";
$res = $link->query($sql);

$arr = array("change_success" => "change success");
echo json_encode($arr);

include '../../close.php';

?>
