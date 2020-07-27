<?PHP
//
//	Matthew Davis
//	01/05/2014
//

include 'http://www.quizzically.co.uk/quizzically/open.php';

$forgot_key = $link->real_escape_string($_POST['forgot_key']);
$apassword = md5($link->real_escape_string($_POST['mob_change_password']));

$sql = "UPDATE A_USER SET RESET = NULL, EXPIRE = NULL, USER_PASSWORD = '$apassword' WHERE RESET = '$forgot_key'";
$res = $link->query($sql);

$arr = array("mob_change_success" => "mob change success");
echo json_encode($arr);

include 'http://www.quizzically.co.uk/quizzically/close.php';

?>
