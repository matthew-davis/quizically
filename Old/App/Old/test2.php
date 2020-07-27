<?php 

// $tag contains the whole JSON string passed in
$messageType = json_decode(stripslashes($_REQUEST[tag]));

// so get the actual data passed in
$inboundData = $messageType[2];

// and the actual tag used int he message so it can be evaluated, and passed back
$realtag = $messageType[1];

// Make sure something will be returned.
$theData[0] = "NO DATA!!";

if ($realtag == "login" ) {
  // Because this is a login, we know we passed the username and password in
  $username=$inboundData[0];
  $password=$inboundData[1];

  // Obviously you would check against MySQL or whatever, but hard coded here for simplicity
  if (($username=="user1") and ($password=="user1")) {
    $theData[0] = "123";  // Pass back the Record ID for future transactions
  } else {
    $theData[0] = "0";  // Invalid Username or Password
  }
}

if ($realtag == "getSomeData") {

    // Because this is after a login, we know we passed the users record number in
    $userID = $inboundData[0];

    // Obviously you would get data from MySQL or whatever, but hard coded here for simplicity
    $i = 0;
    $theData[$i++] = "First some data";
    $theData[$i++] = "And the second piece";
    $theData[$i++] = "And the last piece";
}

$resultData = array("VALUE",$realtag,$theData);

$resultDataJSON = json_encode($resultData); 
echo $resultDataJSON; 

?> 