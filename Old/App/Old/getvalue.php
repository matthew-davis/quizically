<?php

header('Cache-Control: no-cache, must-revalidate');
header('Content-type: application/json');

$con = mysql_connect("localhost","taysidek_testacc","Dsf'!1707");
if (!$con)
  {
  die('Could not connect to mysql: ' . mysql_error());
  }
$tab = mysql_select_db(taysidek_testdb,$con);
if (!$tab)
  {
  die('Could not connect to database: ' . mysql_error());
  }
  
$tagName = $_POST['tag'];
$tagValue = '';

$query =  sprintf("select `tag`, `value` from `TinyWebDB` where `tag` = '%s' limit 1", mysql_real_escape_string($tagName));

if($entry = mysql_fetch_assoc($result))
{
    $tagName = $entry["tag"];
    $tagValue = $entry["value"];
}

echo json_encode(array("VALUE", $tagName, $tagValue));
?>