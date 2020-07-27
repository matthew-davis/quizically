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
$tagValue = $_POST['value'];

$query =  sprintf("update `TinyWebDB` set `value` = '%s' where `tag` = '%s'", mysql_real_escape_string($tagValue), mysql_real_escape_string($tagName));

$query =  sprintf("insert into `TinyWebDB` (`tag`, `value`) values ('%s', '%s')", mysql_real_escape_string($tagName), mysql_real_escape_string($tagValue));

echo json_encode(array("STORED", $tagName, $tagValue));

?>